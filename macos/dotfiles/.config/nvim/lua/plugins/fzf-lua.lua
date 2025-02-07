return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- setup the plugin
    require("fzf-lua").setup({})
    
    -- setup the default keybindings
    vim.keymap.set("n", "<C-\\>", "<cmd>FzfLua buffers<CR>", { silent = true })
    vim.keymap.set("n", "<C-p>", "<cmd>FzfLua files<CR>", { silent = true })
    vim.keymap.set("n", "<C-g>", "<cmd>FzfLua grep<CR>", { silent = true })
    vim.keymap.set("n", "<C-l>", "<cmd>FzfLua live_grep<CR>", { silent = true })
    vim.keymap.set("n", "<C-k>", "<cmd>FzfLua builtin<CR>", { silent = true })
    vim.keymap.set("n", "<F1>", "<cmd>FzfLua help_tags<CR>", { silent = true })

    vim.keymap.set("n", "<leader>gw", "<cmd>FzfLua grep_cword<CR>", { silent = true })
  end,
  opts = {}
}
