return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      -- Names for the leader key groups; each key's own name comes from its `desc`
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Logs" },
      { "<leader>s", group = "Split" },
      { "<leader>v", group = "Vim config" },
      { "<leader>x", group = "Xcode" },

      -- Readable names for Neovim's built-in keys, which otherwise show as function names
      { "gr", group = "Code (built in)" },
      { "gra", desc = "Code action", mode = { "n", "v" } },
      { "grn", desc = "Rename symbol" },
      { "grr", desc = "References" },
      { "gri", desc = "Implementation" },
      { "grt", desc = "Type definition" },
      { "grx", desc = "Run code lens" },
      { "gO", desc = "Symbols in this file" },
      { "]q", desc = "Next quickfix entry (build error)" },
      { "[q", desc = "Previous quickfix entry (build error)" },
      { "]Q", desc = "Last quickfix entry" },
      { "[Q", desc = "First quickfix entry" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Keys for this buffer",
    },
  },
}
