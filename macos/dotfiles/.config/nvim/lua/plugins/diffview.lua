return {
  -- Maintained fork of sindrets/diffview.nvim
  "dlyongemallo/diffview-plus.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "DiffviewOpen", "DiffviewToggle", "DiffviewFileHistory", "DiffviewDiffFiles", "DiffviewLog" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewToggle<cr>", desc = "Toggle diff of all changes" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "History of current file" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History of repo" },
  },
  opts = function()
    local actions = require("diffview.actions")

    -- Free <leader>b (toggle breakpoint) and <leader>e (nvim-tree) inside diff views
    local keymaps = {
      { "n", "<leader>b", false },
      { "n", "<leader>e", false },
      { "n", "<leader>gf", actions.toggle_files, { desc = "Toggle the file panel" } },
    }

    return {
      keymaps = {
        view = keymaps,
        file_panel = keymaps,
        file_history_panel = keymaps,
      },
    }
  end,
}
