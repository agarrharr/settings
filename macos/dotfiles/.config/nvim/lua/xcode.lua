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

-- Log views: splits at the bottom that stream logs while the app runs
local log_views = {}
local log_ns = vim.api.nvim_create_namespace("xcode-logs")

-- Colors for formatted log views (purple like Xcode's runtime issues)
vim.api.nvim_set_hl(0, "XcodeLogRuntimeWarning", { fg = "#cba6f7", default = true })
vim.api.nvim_set_hl(0, "XcodeLogWarning", { link = "DiagnosticWarn", default = true })
vim.api.nvim_set_hl(0, "XcodeLogError", { link = "DiagnosticError", default = true })
vim.api.nvim_set_hl(0, "XcodeLogTime", { link = "Comment", default = true })
vim.api.nvim_set_hl(0, "XcodeLogLabel", { link = "Identifier", default = true })

---@class XcodeLogEntry
---@field label string shown before the message, e.g. the subsystem
---@field message string
---@field hl string|nil highlight group for the label and message

---@class XcodeLogView
---@field command string[]
---@field title string
---@field format (fun(event: table): XcodeLogEntry)|nil when set, `command` outputs `log stream --style ndjson`
---  and each event is shown formatted; otherwise the output is shown as-is in a terminal
---@field on_event (fun(event: table, append: fun(entry: XcodeLogEntry)))|nil used instead of `format` to
---  handle each event, e.g. to look things up before appending its entry

local function nil_if_null(value)
    return value ~= vim.NIL and value or nil
end

---Appends a formatted entry to a log buffer, keeping windows at the bottom scrolled to the bottom
local function append_log_entry(buf, event, entry)
    local time = (nil_if_null(event.timestamp) or ""):match("%d+:%d+:%d+%.%d%d%d") or ""
    local prefix = time .. "  " .. entry.label .. "  "
    local lines = vim.split(entry.message, "\n", { trimempty = true })
    if #lines == 0 then
        lines = { "" }
    end
    lines[1] = prefix .. lines[1]
    for i = 2, #lines do
        lines[i] = string.rep(" ", #time + 2) .. lines[i]
    end

    local following = {}
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        following[win] = vim.api.nvim_win_get_cursor(win)[1] == vim.api.nvim_buf_line_count(buf)
    end

    local first = vim.api.nvim_buf_line_count(buf)
    local is_empty = first == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
    if is_empty then
        first = 0
    end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, first, is_empty and 1 or first, false, lines)
    vim.bo[buf].modifiable = false

    vim.api.nvim_buf_set_extmark(buf, log_ns, first, 0, { end_col = #time, hl_group = "XcodeLogTime" })
    vim.api.nvim_buf_set_extmark(buf, log_ns, first, #time + 2, {
        end_col = #time + 2 + #entry.label,
        hl_group = entry.hl or "XcodeLogLabel",
    })
    if entry.hl then
        for i, line in ipairs(lines) do
            local col = i == 1 and #prefix or #time + 2
            vim.api.nvim_buf_set_extmark(buf, log_ns, first + i - 1, col, { end_col = #line, hl_group = entry.hl })
        end
    end

    local last = vim.api.nvim_buf_line_count(buf)
    for win, was_following in pairs(following) do
        if was_following then
            vim.api.nvim_win_set_cursor(win, { last, 0 })
        end
    end
end

---Starts a formatted log view in the current window and returns its job
---@param view XcodeLogView
local function start_formatted_log_view(buf, view)
    vim.bo[buf].modifiable = false
    local partial = ""

    return vim.fn.jobstart(view.command, {
        on_stdout = function(_, data)
            data[1] = partial .. data[1]
            partial = table.remove(data)
            for _, line in ipairs(data) do
                if line:sub(1, 1) == "{" then
                    local ok, event = pcall(vim.json.decode, line)
                    if ok and vim.api.nvim_buf_is_valid(buf) then
                        if view.on_event then
                            view.on_event(event, function(entry)
                                if vim.api.nvim_buf_is_valid(buf) then
                                    append_log_entry(buf, event, entry)
                                end
                            end)
                        else
                            append_log_entry(buf, event, view.format(event))
                        end
                    end
                end
            end
        end,
    })
end

---Opens a window for a log view: beside any log view already showing at the bottom,
---or else as a new split across the bottom
local function open_log_window()
    for _, view in pairs(log_views) do
        local win = vim.api.nvim_buf_is_valid(view.buf) and vim.fn.bufwinid(view.buf) or -1
        if win ~= -1 then
            vim.api.nvim_set_current_win(win)
            vim.cmd("rightbelow vsplit")
            return
        end
    end

    vim.cmd("botright 12split")
end

---Starts a log view, showing it at the bottom or (with `show` false) running it in the background
---@param name string
---@param view XcodeLogView
---@param show boolean
local function start_log_view(name, view, show)
    local original_win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    if show then
        open_log_window()
        vim.api.nvim_win_set_buf(0, buf)
        vim.wo.wrap = false
    end

    local job
    if view.format or view.on_event then
        job = start_formatted_log_view(buf, view)
    else
        vim.api.nvim_buf_call(buf, function()
            job = vim.fn.jobstart(view.command, { term = true })
        end)
    end

    vim.api.nvim_buf_set_name(buf, view.title)
    vim.bo[buf].bufhidden = "hide"
    log_views[name] = { buf = buf, job = job }
    vim.api.nvim_set_current_win(original_win)
end

---Whether a log view's stream is running
local function is_log_view_running(name)
    local view = log_views[name]
    return view ~= nil and vim.api.nvim_buf_is_valid(view.buf) and vim.fn.jobwait({ view.job }, 0)[1] == -1
end

---Shows or hides a log split, starting it if needed.
---`get_view` returns what to run, or nil (after notifying) if it can't start.
---@param name string
---@param get_view fun(): XcodeLogView|nil
local function toggle_log_view(name, get_view)
    local existing = log_views[name]

    -- Start over if the stream stopped (e.g. the simulator was shut down)
    if existing and vim.fn.jobwait({ existing.job }, 0)[1] ~= -1 then
        if vim.api.nvim_buf_is_valid(existing.buf) then
            vim.api.nvim_buf_delete(existing.buf, { force = true })
        end
        existing = nil
        log_views[name] = nil
    end

    if existing and vim.api.nvim_buf_is_valid(existing.buf) then
        local win = vim.fn.bufwinid(existing.buf)
        if win ~= -1 then
            vim.api.nvim_win_close(win, false)
        else
            local original_win = vim.api.nvim_get_current_win()
            open_log_window()
            vim.api.nvim_win_set_buf(0, existing.buf)
            vim.wo.wrap = false
            vim.api.nvim_set_current_win(original_win)
        end
        return
    end

    local view = get_view()
    if view then
        start_log_view(name, view, true)
    end
end

---Whether a log view is showing in a window
local function is_log_view_visible(name)
    local view = log_views[name]
    return view ~= nil and vim.api.nvim_buf_is_valid(view.buf) and vim.fn.bufwinid(view.buf) ~= -1
end

local function is_simulator_booted(udid)
    local devices = vim.json.decode(vim.fn.system({ "xcrun", "simctl", "list", "devices", "--json" })).devices
    for _, runtime_devices in pairs(devices) do
        for _, device in ipairs(runtime_devices) do
            if device.udid == udid then
                return device.state == "Booted"
            end
        end
    end
    return false
end

-- Runtime warnings (Xcode's purple issues), minus Apple's internal performance diagnostics
local runtime_warnings_predicate = 'subsystem == "com.apple.runtime-issues" AND category != "SkipRuntimeIssues"'

-- The app's own log messages: Logger/os_log from the app and its packages (e.g. TCA, Firebase)
-- and runtime warnings, without Apple frameworks' messages
local app_messages_predicate = 'eventType == "logEvent" AND ((subsystem != "" AND NOT subsystem BEGINSWITH "com.apple.") OR ('
    .. runtime_warnings_predicate
    .. "))"

---Returns xcodebuild.nvim's settings if its selected simulator is running the app, or else the problem
---@return table|nil settings
---@return string|nil problem
local function running_simulator()
    local ok, project_config = pcall(require, "xcodebuild.project.config")
    local settings = ok and project_config.settings or {}
    if settings.platform ~= "iOS Simulator" or not settings.destination then
        return nil, "select a simulator with :XcodebuildSelectDevice first"
    end

    if not settings.productName then
        return nil, "build the app first"
    end

    if not is_simulator_booted(settings.destination) then
        return nil, (settings.deviceName or "the simulator") .. " isn't running. Run the app first."
    end

    return settings
end

---Returns a command streaming the app's unified log from the simulator
---@param settings table from running_simulator()
---@param extra_predicate string|nil narrows the log further
---@param style string|nil "compact" (default) or "ndjson"
local function log_stream_command(settings, extra_predicate, style)
    local predicate = string.format('process == "%s"', settings.productName)
    if extra_predicate then
        predicate = predicate .. " AND " .. extra_predicate
    end

    return {
        "xcrun", "simctl", "spawn", settings.destination,
        "log", "stream", "--style", style or "compact", "--level", "debug", "--predicate", predicate,
    }
end

---Returns a function for toggle_log_view that streams the simulator's log, or warns why it can't
---@param title string
---@param extra_predicate string|nil
---@param format (fun(event: table): XcodeLogEntry)|nil shows formatted entries instead of raw output
local function simulator_log_view(title, extra_predicate, format)
    return function()
        local settings, problem = running_simulator()
        if not settings then
            vim.notify(title .. ": " .. problem, vim.log.levels.WARN)
            return nil
        end

        return {
            command = log_stream_command(settings, extra_predicate, format and "ndjson" or nil),
            title = title .. " (" .. (settings.deviceName or settings.destination) .. ")",
            format = format,
        }
    end
end

---Purple for runtime warnings, red for errors from the app's own code and packages,
---yellow for errors from Apple's frameworks
---@return XcodeLogEntry
local function format_issue(event)
    local subsystem = nil_if_null(event.subsystem) or ""
    local entry = { message = nil_if_null(event.eventMessage) or "" }

    if subsystem == "com.apple.runtime-issues" then
        entry.label = nil_if_null(event.category) or "Runtime"
        entry.hl = "XcodeLogRuntimeWarning"
    else
        entry.label = subsystem ~= "" and subsystem or vim.fs.basename(nil_if_null(event.senderImagePath) or "")
        local from_apple = subsystem == "" or vim.startswith(subsystem, "com.apple.")
        entry.hl = from_apple and "XcodeLogWarning" or "XcodeLogError"
    end

    return entry
end

---@return XcodeLogEntry
local function format_event(event)
    return {
        label = nil_if_null(event.subsystem) or "",
        message = nil_if_null(event.eventMessage) or "",
    }
end

-- Issue tracking: counts, notifications, and code marks for the issues view, which also runs in
-- the background after the app launches (see M.start_issue_monitor)

local issue_counts = { runtime = 0, errors = 0 }
local issues_process_id = nil
local issue_marks_ns = vim.api.nvim_create_namespace("xcode-runtime-issues")
vim.diagnostic.config({ signs = { text = { [vim.diagnostic.severity.WARN] = "🟣" } } }, issue_marks_ns)

local pending_notification = { runtime = 0, errors = 0 }
local notification_scheduled = false

---Notifies about new issues, grouping bursts into one notification (unless the issues view is showing)
local function notify_issue(kind)
    if is_log_view_visible("issues") then
        return
    end

    pending_notification[kind] = pending_notification[kind] + 1
    if notification_scheduled then
        return
    end

    notification_scheduled = true
    vim.defer_fn(function()
        local parts = {}
        if pending_notification.runtime > 0 then
            table.insert(parts, string.format("🟣 %d runtime warning%s", pending_notification.runtime, pending_notification.runtime == 1 and "" or "s"))
        end
        if pending_notification.errors > 0 then
            table.insert(parts, string.format("✖ %d error%s", pending_notification.errors, pending_notification.errors == 1 and "" or "s"))
        end
        local message = table.concat(parts, ", ") .. "  (<leader>xw)"

        local has_fidget, fidget = pcall(require, "fidget")
        if has_fidget then
            fidget.notify(message, vim.log.levels.WARN)
        else
            vim.notify(message, vim.log.levels.WARN)
        end

        pending_notification = { runtime = 0, errors = 0 }
        notification_scheduled = false
    end, 1000)
end

---Runs a command in the background and calls `callback(lines)` with its output on the main loop
local function run_shell(command, callback)
    vim.system(command, { text = true }, function(result)
        vim.schedule(function()
            callback(vim.split(result.stdout or "", "\n", { trimempty = true }))
        end)
    end)
end

local app_images_cache = {}

---Finds the Mach-O images in the app bundle, keyed by UUID, with their __TEXT load address
local function app_images(process_image_path, callback)
    if app_images_cache[process_image_path] then
        return callback(app_images_cache[process_image_path])
    end

    local bundle = vim.fs.dirname(process_image_path)
    local files = { process_image_path }
    vim.list_extend(files, vim.fn.glob(bundle .. "/*.dylib", false, true))

    local script = [[
for f in "$@"; do
  uuid=$(dwarfdump --uuid "$f" | awk '/arm64/ { print $2; exit }')
  vmaddr=$(otool -l "$f" | awk '/segname __TEXT$/ { getline; print $2; exit }')
  echo "$uuid $vmaddr $f"
done]]
    run_shell({ "sh", "-c", script, "sh", unpack(files) }, function(lines)
        local images = {}
        for _, line in ipairs(lines) do
            local uuid, vmaddr, path = line:match("^(%S+) (%S+) (.+)$")
            if uuid then
                -- Debug builds usually have their debug info in place; use a dSYM if there is one
                local dsym = path .. ".dSYM/Contents/Resources/DWARF/" .. vim.fs.basename(path)
                images[uuid] = { path = vim.fn.filereadable(dsym) == 1 and dsym or path, vmaddr = tonumber(vmaddr) }
            end
        end
        app_images_cache[process_image_path] = images
        callback(images)
    end)
end

local project_files_cache = {}

---Maps file names to paths for the files tracked in the project's git repo
local function project_files(callback)
    local cwd = vim.fn.getcwd()
    if project_files_cache[cwd] then
        return callback(project_files_cache[cwd])
    end

    run_shell({ "git", "-C", cwd, "ls-files", "--full-name", "*.swift" }, function(lines)
        local root = vim.trim(vim.fn.system({ "git", "-C", cwd, "rev-parse", "--show-toplevel" }))
        local files = {}
        for _, path in ipairs(lines) do
            files[vim.fs.basename(path)] = files[vim.fs.basename(path)] or (root .. "/" .. path)
        end
        project_files_cache[cwd] = files
        callback(files)
    end)
end

---Finds where in the project's own code an issue came from, from its backtrace.
---Calls `callback(location)` with { path, line, func } or nil.
local function locate_issue(event, callback)
    local frames = type(event.backtrace) == "table" and event.backtrace.frames or {}
    local process_image_path = nil_if_null(event.processImagePath)
    if #frames == 0 or not process_image_path then
        return callback(nil)
    end

    app_images(process_image_path, function(images)
        -- Symbolicate the frames in the app's own images, in order
        local by_image = {}
        for index, frame in ipairs(frames) do
            local image = images[frame.imageUUID]
            if image and image.vmaddr then
                by_image[frame.imageUUID] = by_image[frame.imageUUID] or { image = image, frames = {} }
                table.insert(by_image[frame.imageUUID].frames, { index = index, address = image.vmaddr + frame.imageOffset })
            end
        end

        local symbols = {}
        local remaining = vim.tbl_count(by_image)
        if remaining == 0 then
            return callback(nil)
        end

        local function finish()
            project_files(function(files)
                for index = 1, #frames do
                    local symbol = symbols[index]
                    local func, file, line = (symbol or ""):match("^(.-) %(in .-%) %((.-):(%d+)%)$")
                    if file and files[file] then
                        return callback({ path = files[file], line = tonumber(line), func = func })
                    end
                end
                callback(nil)
            end)
        end

        for _, group in pairs(by_image) do
            local command = { "atos", "-o", group.image.path, "-arch", "arm64", "-l", string.format("0x%x", group.image.vmaddr) }
            for _, frame in ipairs(group.frames) do
                table.insert(command, string.format("0x%x", frame.address))
            end
            run_shell(command, function(lines)
                for i, frame in ipairs(group.frames) do
                    symbols[frame.index] = lines[i]
                end
                remaining = remaining - 1
                if remaining == 0 then
                    finish()
                end
            end)
        end
    end)
end

---Clears the counts and code marks when log events start coming from a new run of the app
local function start_new_run_if_needed(event, append)
    local process_id = nil_if_null(event.processID)
    if process_id == issues_process_id then
        return
    end

    issues_process_id = process_id
    issue_counts = { runtime = 0, errors = 0 }
    vim.diagnostic.reset(issue_marks_ns)
    append({ label = "──", message = "New run of the app (process " .. tostring(process_id) .. ") ──", hl = "XcodeLogTime" })
end

---Counts, notifies about, and marks the code for each issue, then shows it in the issues view
local function process_issue(event, append)
    start_new_run_if_needed(event, append)

    local entry = format_issue(event)
    if entry.hl == "XcodeLogWarning" then
        return append(entry) -- errors from Apple's frameworks are shown, but not counted
    end

    local kind = entry.hl == "XcodeLogRuntimeWarning" and "runtime" or "errors"
    issue_counts[kind] = issue_counts[kind] + 1
    notify_issue(kind)

    if kind ~= "runtime" then
        return append(entry)
    end

    locate_issue(event, function(location)
        -- IssueReporting's messages can't be read from the log, only their location
        local unreadable = entry.message == "" or entry.message:find("^<compose failure")
        if location then
            local where = vim.fs.basename(location.path) .. ":" .. location.line .. " in " .. location.func
            entry.message = unreadable and ("Runtime warning at " .. where) or (entry.message .. "\n↳ " .. where)

            -- Load the file first, or the sign is drawn on line 1 of the still-empty buffer
            local buf = vim.fn.bufadd(location.path)
            vim.fn.bufload(buf)
            local marks = vim.diagnostic.get(buf, { namespace = issue_marks_ns })
            table.insert(marks, {
                lnum = location.line - 1,
                col = 0,
                message = unreadable and ("Runtime warning in " .. location.func) or entry.message,
                severity = vim.diagnostic.severity.WARN,
                source = "runtime warning",
            })
            vim.diagnostic.set(issue_marks_ns, buf, marks)
        elseif unreadable then
            entry.message = "Runtime warning (message and location unavailable)"
        end
        append(entry)
    end)
end

---Returns the number of runtime warnings and errors from the app's own code in the current run
---@return { runtime: integer, errors: integer }
function M.issue_counts()
    return issue_counts
end

---Starts the issues view in the background (if it isn't running), so new issues are counted and
---notified about even while it's hidden. Meant to run when the app launches.
function M.start_issue_monitor()
    if is_log_view_running("issues") then
        return
    end

    local settings = running_simulator()
    if settings then
        start_log_view("issues", M.issues_view(), false)
    end
end

---Returns the issues view: runtime warnings (Xcode's purple issues, e.g. from SwiftUI or
---IssueReporting's reportIssue) and errors, colored by kind
---@return XcodeLogView|nil
function M.issues_view()
    local view = simulator_log_view(
        "Issues",
        'eventType == "logEvent" AND (messageType == error OR messageType == fault) AND category != "SkipRuntimeIssues"',
        format_issue
    )()
    if view then
        view.on_event = process_issue
    end
    return view
end

---Shows or hides the issues view
function M.toggle_issues()
    toggle_log_view("issues", M.issues_view)
end

---Shows or hides log messages from the subsystems listed in the project's
---.nvim/xcodebuild/log_events.txt (e.g. the app's TCA and analytics loggers)
function M.toggle_events()
    local ok, appdata = pcall(require, "xcodebuild.project.appdata")
    if not ok or not appdata.appdir then
        vim.notify("Events: run :XcodebuildSetup first", vim.log.levels.WARN)
        return
    end

    local path = appdata.appdir .. "/log_events.txt"
    if vim.fn.filereadable(path) == 0 then
        vim.fn.writefile({
            "# Log subsystems for the events panel (<leader>xE in Neovim)",
            "#",
            "# One subsystem per line: the subsystem of a Logger(subsystem:category:) in the app.",
            "",
        }, path)
    end

    local subsystems = vim.tbl_filter(function(line)
        return vim.trim(line) ~= "" and not vim.startswith(line, "#")
    end, vim.fn.readfile(path))

    if #subsystems == 0 then
        vim.notify("Events: add the log subsystems to show, one per line", vim.log.levels.INFO)
        vim.cmd.tabedit(path)
        return
    end

    local quoted = vim.tbl_map(function(subsystem)
        return string.format('"%s"', vim.trim(subsystem))
    end, subsystems)

    toggle_log_view(
        "events",
        simulator_log_view(
            "Events",
            string.format('eventType == "logEvent" AND subsystem IN {%s}', table.concat(quoted, ", ")),
            format_event
        )
    )
end

---Shows issues and events side by side at the bottom, or hides both if they're showing
function M.toggle_issues_and_events()
    local both_visible = is_log_view_visible("issues") and is_log_view_visible("events")
    if both_visible or not is_log_view_visible("issues") then
        M.toggle_issues()
    end
    if both_visible or not is_log_view_visible("events") then
        M.toggle_events()
    end
end

---Shows or hides everything the app logs to the unified log (Logger, os_log, Apple frameworks)
function M.toggle_all_logs()
    toggle_log_view("all_logs", simulator_log_view("All logs"))
end

---Shows or hides what Xcode's console would show: the app's printed output (stdout/stderr, which
---xcodebuild.nvim saves on every run) together with the app's own log messages and runtime warnings
function M.toggle_app_output()
    toggle_log_view("app_output", function()
        local ok, appdata = pcall(require, "xcodebuild.project.appdata")
        if not ok or not appdata.app_logs_filepath then
            vim.notify("App output: run :XcodebuildSetup first", vim.log.levels.WARN)
            return nil
        end

        -- -F keeps following when xcodebuild.nvim clears the file at the start of each run
        local tail = { "tail", "-n", "+1", "-F", appdata.app_logs_filepath }

        local settings, problem = running_simulator()
        if not settings then
            vim.notify("App output: showing printed output only (" .. problem .. ")", vim.log.levels.INFO)
            return { command = tail, title = "App output" }
        end

        -- Run both, and stop tail when the log stream stops
        local script = 'file=$1; shift; trap "kill 0" EXIT HUP TERM; tail -n +1 -F "$file" & "$@"'
        local command = { "sh", "-c", script, "sh", appdata.app_logs_filepath }
        vim.list_extend(command, log_stream_command(settings, app_messages_predicate))
        return { command = command, title = "App output (" .. (settings.deviceName or settings.destination) .. ")" }
    end)
end

return M
