-- Helpers for using Xcode alongside Neovim:
-- follow Swift files in Xcode (switching to the file's scheme) and control the canvas
local M = {}

local follow_group = vim.api.nvim_create_augroup("XcodeFollow", { clear = true })
local following = false
local last_file = nil

-- Makes Xcode's active scheme the one named after the file's closest folder (e.g. a package
-- module), so its canvas can preview the file, or else the fallback scheme (the app)
local scheme_script = [[
on run argv
  set filePath to item 1 of argv
  set fallbackScheme to item 2 of argv
  set candidates to items 3 thru -1 of argv
  tell application "Xcode"
    if (count of workspace documents) is 0 then return ""
    set ws to workspace document 1
    set AppleScript's text item delimiters to "/"
    repeat with doc in workspace documents
      set docDir to (text items 1 thru -2 of (path of doc as text)) as text
      if filePath starts with (docDir & "/") then
        set ws to doc
        exit repeat
      end if
    end repeat
    set schemeNames to name of schemes of ws
    set targetScheme to ""
    repeat with candidate in candidates
      if schemeNames contains (candidate as text) then
        set targetScheme to candidate as text
        exit repeat
      end if
    end repeat
    if targetScheme is "" and schemeNames contains fallbackScheme then set targetScheme to fallbackScheme
    if targetScheme is not "" and name of active scheme of ws is not targetScheme then
      set active scheme of ws to scheme targetScheme of ws
      return targetScheme
    end if
  end tell
  return ""
end run
]]

local function open_in_xcode(bufnr)
    local file = vim.api.nvim_buf_get_name(bufnr)
    if file == "" or file == last_file or vim.fn.filereadable(file) == 0 then
        return
    end

    last_file = file

    -- Folder names from closest to farthest, e.g. Views, ProfileFeature, Sources, ...
    local candidates = vim.split(vim.fs.dirname(file), "/", { trimempty = true })
    candidates = vim.iter(candidates):rev():totable()

    -- Fall back to the scheme picked in :XcodebuildSetup (the app)
    local ok, project_config = pcall(require, "xcodebuild.project.config")
    local fallback = ok and project_config.settings.scheme or ""

    local cmd = { "osascript", "-e", scheme_script, file, fallback }
    vim.list_extend(cmd, candidates)

    vim.system(cmd, {}, function(result)
        local scheme = vim.trim(result.stdout or "")
        if scheme ~= "" then
            vim.schedule(function()
                vim.notify("Xcode scheme: " .. scheme)
            end)
        end

        vim.system({ "xed", "-b", file })
    end)
end

---Toggles opening Swift files in Xcode (in the background) as you switch to them,
---so the canvas shows their previews
function M.toggle_follow()
    following = not following
    last_file = nil
    vim.api.nvim_clear_autocmds({ group = follow_group })

    if following then
        vim.api.nvim_create_autocmd("BufEnter", {
            group = follow_group,
            pattern = "*.swift",
            callback = function(args)
                open_in_xcode(args.buf)
            end,
        })

        if vim.bo.filetype == "swift" then
            open_in_xcode(0)
        end
    end

    vim.notify("Xcode follow " .. (following and "on" or "off"))
end

-- Clicks Editor > Canvas menu items; the terminal needs Accessibility permission.
-- Refresh works in the background. Xcode disables the show/hide toggle unless it's
-- the active app, so toggling briefly brings Xcode forward and then switches back.
local canvas_script = [[
on run argv
  set mode to item 1 of argv
  tell application "System Events"
    set previousApp to first application process whose frontmost is true
    if mode is "toggle" then
      set frontmost of process "Xcode" to true
      repeat 20 times
        if frontmost of process "Xcode" then exit repeat
        delay 0.05
      end repeat
    end if
  end tell
  try
    my click_canvas_item(mode)
  on error errorMessage
    tell application "System Events" to set frontmost of previousApp to true
    error errorMessage
  end try
  tell application "System Events" to set frontmost of previousApp to true
end run

on click_canvas_item(mode)
  tell application "System Events" to tell process "Xcode"
    set n to count of menu items of menu 1 of menu bar item "Editor" of menu bar 1
    repeat with i from 1 to n
      set itemName to name of menu item i of menu 1 of menu bar item "Editor" of menu bar 1
      if itemName is "Canvas" or itemName is "Preview" then
        -- The show/hide toggle is named "Canvas" or "Preview" depending on Xcode's state.
        -- A second "Canvas" item is a submenu with "Refresh Canvas" (only while the canvas is showing).
        set hasSubmenu to true
        try
          count of menu items of menu 1 of menu item i of menu 1 of menu bar item "Editor" of menu bar 1
        on error
          set hasSubmenu to false
        end try
        if mode is "toggle" and not hasSubmenu then
          -- The toggle enables once Xcode has finished becoming active
          repeat 20 times
            if enabled of menu item i of menu 1 of menu bar item "Editor" of menu bar 1 then exit repeat
            delay 0.05
          end repeat
          click menu item i of menu 1 of menu bar item "Editor" of menu bar 1
          return
        else if mode is "refresh" and hasSubmenu then
          click menu item "Refresh Canvas" of menu 1 of menu item i of menu 1 of menu bar item "Editor" of menu bar 1
          return
        end if
      end if
    end repeat
  end tell
  if mode is "refresh" then error "Refresh Canvas isn't available (is the canvas showing?)"
  error "Canvas menu item not found"
end click_canvas_item
]]

local function canvas(mode)
    vim.system({ "osascript", "-e", canvas_script, mode }, {}, function(result)
        if result.code ~= 0 then
            vim.schedule(function()
                vim.notify("Xcode canvas " .. mode .. " failed: " .. vim.trim(result.stderr), vim.log.levels.ERROR)
            end)
        end
    end)
end

---Refreshes Xcode's canvas without bringing Xcode to the front
function M.refresh_canvas()
    canvas("refresh")
end

---Shows or hides Xcode's canvas
function M.toggle_canvas()
    canvas("toggle")
end

return M
