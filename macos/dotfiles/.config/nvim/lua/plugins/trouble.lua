return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  -- Under Code (<leader>c), next to the fzf-lua symbol search (cs / cS)
  keys = {
    { "<leader>cd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics in the project" },
    { "<leader>cD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics in this file" },
    { "<leader>co", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Outline of this file" },
    { "<leader>cu", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Definitions and references" },
    { "<leader>cq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (build errors)" },
  },
}
