local progress_handle

return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("xcodebuild").setup({
      show_build_progress_bar = false,
      -- Use fzf-lua for pickers (snacks.nvim is installed for images, not as a picker)
      integrations = {
        telescope_nvim = { enabled = false },
        snacks_nvim = { enabled = false },
        fzf_lua = { enabled = true },
      },
      logs = {
        auto_open_on_success_tests = false,
        auto_open_on_failed_tests = false,
        auto_open_on_success_build = false,
        auto_open_on_failed_build = false,
        auto_focus = false,
        auto_close_on_app_launch = true,
        only_summary = true,
        notify = function(message, severity)
          local fidget = require("fidget")
          if progress_handle then
            progress_handle.message = message
            if not message:find("Loading") then
              progress_handle:finish()
              progress_handle = nil
              if vim.trim(message) ~= "" then
                fidget.notify(message, severity)
              end
            end
          else
            fidget.notify(message, severity)
          end
        end,
        notify_progress = function(message)
          local progress = require("fidget.progress")

          if progress_handle then
            progress_handle.title = ""
            progress_handle.message = message
          else
            progress_handle = progress.handle.create({
              message = message,
              lsp_client = { name = "xcodebuild.nvim" },
            })
          end
        end,
      },
      code_coverage = {
        enabled = true,
      },
      -- Only errors, so ]q / [q step through what's breaking the build
      quickfix = {
        show_warnings_on_quickfixlist = false,
      },
    })

    -- Show build errors in the gutter as soon as the build finishes,
    -- without waiting for sourcekit-lsp to analyze each file
    local build_errors_ns = vim.api.nvim_create_namespace("xcodebuild-build-errors")
    local build_errors_group = vim.api.nvim_create_augroup("XcodebuildBuildErrors", { clear = true })

    -- Watch for runtime warnings and errors while the app runs (counted in lualine, notified,
    -- and marked in the code), even when the issues view (<leader>xw) is hidden
    vim.api.nvim_create_autocmd("User", {
      group = build_errors_group,
      pattern = "XcodebuildApplicationLaunched",
      callback = function()
        require("xcode").start_issue_monitor()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = build_errors_group,
      pattern = "XcodebuildBuildStarted",
      callback = function()
        vim.diagnostic.reset(build_errors_ns)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = build_errors_group,
      pattern = "XcodebuildBuildFinished",
      callback = function(args)
        vim.diagnostic.reset(build_errors_ns)

        local by_file = {}
        for _, error in ipairs(args.data.errors or {}) do
          if error.filepath and error.lineNumber then
            by_file[error.filepath] = by_file[error.filepath] or {}
            table.insert(by_file[error.filepath], {
              lnum = error.lineNumber - 1,
              col = math.max((error.columnNumber or 1) - 1, 0),
              message = table.concat(error.message or {}, "\n"),
              severity = vim.diagnostic.severity.ERROR,
              source = "xcodebuild",
            })
          end
        end

        for filepath, diagnostics in pairs(by_file) do
          -- Load the file first, or the sign is drawn on line 1 of the still-empty buffer
          local bufnr = vim.fn.bufadd(filepath)
          vim.fn.bufload(bufnr)
          vim.diagnostic.set(build_errors_ns, bufnr, diagnostics)
        end
      end,
    })

    -- stylua: ignore start
    vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" })
    vim.keymap.set("n", "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", { desc = "Show Project Manager Actions" })

    vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
    vim.keymap.set("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build For Testing" })
    vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })

    vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    vim.keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })
    vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })

    vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
    vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
    vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Code Coverage Report" })
    vim.keymap.set("n", "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<cr>", { desc = "Toggle Test Explorer" })
    vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildFailingSnapshots<cr>", { desc = "Show Failing Snapshots" })

    vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
    vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
    vim.keymap.set("n", "<leader>xq", "<cmd>FzfLua quickfix<cr>", { desc = "Show QuickFix List" })

    -- Xcode app helpers (lua/xcode.lua)
    vim.api.nvim_create_user_command("XcodeFollow", function() require("xcode").toggle_follow() end, { desc = "Toggle opening Swift files in Xcode" })
    vim.keymap.set("n", "<leader>xo", function() require("xcode").toggle_follow() end, { desc = "Toggle Xcode follow" })
    vim.keymap.set("n", "<leader>xv", function() require("xcode").refresh_canvas() end, { desc = "Refresh Xcode canvas" })
    vim.keymap.set("n", "<leader>xV", function() require("xcode").toggle_canvas() end, { desc = "Show/hide Xcode canvas" })
    vim.keymap.set("n", "<leader>xw", function() require("xcode").toggle_issues() end, { desc = "Show/hide runtime warnings and errors" })
    vim.keymap.set("n", "<leader>xE", function() require("xcode").toggle_events() end, { desc = "Show/hide events (subsystems in log_events.txt)" })
    vim.keymap.set("n", "<leader>xL", function() require("xcode").toggle_issues_and_events() end, { desc = "Show/hide issues and events side by side" })
    vim.keymap.set("n", "<leader>xa", function() require("xcode").toggle_app_output() end, { desc = "Show/hide app output" })
    vim.keymap.set("n", "<leader>xA", function() require("xcode").toggle_all_logs() end, { desc = "Show/hide all app logs" })
  end,
}
