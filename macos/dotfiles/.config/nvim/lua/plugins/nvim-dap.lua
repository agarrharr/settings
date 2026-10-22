return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "wojciech-kulik/xcodebuild.nvim"
  },
  config = function()
    local xcodebuild = require("xcodebuild.integrations.dap")

    -- Uses lldb-dap bundled with Xcode 16+
    xcodebuild.setup()
 
    vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build and debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug without building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug this test class" })
    vim.keymap.set("n", "<leader>db", xcodebuild.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dB", xcodebuild.toggle_message_breakpoint, { desc = "Toggle message breakpoint" })
    vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Stop debugging" })

    local dap = require("dap")
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over (next line)" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
  end,
}
