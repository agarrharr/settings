return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    -- xcodebuild.nvim sets these globals once a project is set up (see :help xcodebuild.lualine)
    local function in_xcode_project()
      return vim.g.xcodebuild_device_name ~= nil
    end

    local function xcodebuild_device()
      if vim.g.xcodebuild_platform == "macOS" then
        return " macOS"
      end

      if vim.g.xcodebuild_os then
        return " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
      end

      return " " .. vim.g.xcodebuild_device_name
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin-nvim", -- follows the flavour set in colorscheme.lua
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          -- Runtime warnings and errors from the app's own code in the current run (lua/xcode.lua)
          {
            function()
              return "🟣 " .. package.loaded["xcode"].issue_counts().runtime
            end,
            cond = function()
              local xcode = package.loaded["xcode"]
              return xcode ~= nil and xcode.issue_counts().runtime > 0
            end,
            color = "XcodeLogRuntimeWarning",
          },
          {
            function()
              return "✖ " .. package.loaded["xcode"].issue_counts().errors
            end,
            cond = function()
              local xcode = package.loaded["xcode"]
              return xcode ~= nil and xcode.issue_counts().errors > 0
            end,
            color = "DiagnosticError",
          },
          {
            function()
              return " " .. vim.g.xcodebuild_last_status
            end,
            cond = function()
              return vim.g.xcodebuild_last_status ~= nil
            end,
            color = "Comment",
          },
          {
            function()
              return "󰙨 " .. vim.g.xcodebuild_test_plan
            end,
            cond = function()
              return vim.g.xcodebuild_test_plan ~= nil
            end,
            color = "String",
          },
          { xcodebuild_device, cond = in_xcode_project, color = "WarningMsg" },
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    })
  end,
}
