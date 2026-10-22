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
  opts = {},
}
