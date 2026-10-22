return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Names for the leader key groups; each key's own name comes from its `desc`
    spec = {
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lazy" },
      { "<leader>m", group = "Format and lint" },
      { "<leader>s", group = "Split" },
      { "<leader>v", group = "Vim config" },
      { "<leader>x", group = "Xcode" },
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
