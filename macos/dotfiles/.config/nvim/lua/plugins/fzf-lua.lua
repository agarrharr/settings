return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- setup the plugin
    require("fzf-lua").setup({})
    
    -- setup the default keybindings
    vim.keymap.set("n", "<C-\\>", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "Find open buffers" })
    vim.keymap.set("n", "<C-p>", "<cmd>FzfLua files<CR>", { silent = true, desc = "Find files" })
    vim.keymap.set("n", "<C-g>", "<cmd>FzfLua grep<CR>", { silent = true, desc = "Grep, then narrow the results" })
    -- Not <C-l>/<C-k>, which move between panes (see init.lua)
    vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<CR>", { silent = true, desc = "Live grep" })
    vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua builtin<CR>", { silent = true, desc = "All fzf-lua pickers" })
    vim.keymap.set("n", "<F1>", "<cmd>FzfLua help_tags<CR>", { silent = true, desc = "Search help" })

    vim.keymap.set("n", "<leader>gw", "<cmd>FzfLua grep_cword<CR>", { silent = true, desc = "Grep the word under the cursor" })
  end,
  opts = {}
}
