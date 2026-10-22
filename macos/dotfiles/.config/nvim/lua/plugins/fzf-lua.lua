return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- setup the plugin
    require("fzf-lua").setup({})

    -- Find (<leader>f)
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { silent = true, desc = "Files" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<CR>", { silent = true, desc = "Grep, then narrow the results" })
    vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<CR>", { silent = true, desc = "Live grep" })
    vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", { silent = true, desc = "Word under the cursor" })
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "Open buffers" })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { silent = true, desc = "Help" })
    vim.keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<CR>", { silent = true, desc = "Quickfix list (build errors)" })
    vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua builtin<CR>", { silent = true, desc = "All pickers" })

    -- Shortcuts for the most common ones (not <C-l>/<C-k>, which move between panes; see init.lua)
    vim.keymap.set("n", "<C-p>", "<cmd>FzfLua files<CR>", { silent = true, desc = "Find files" })
    vim.keymap.set("n", "<C-g>", "<cmd>FzfLua grep<CR>", { silent = true, desc = "Grep, then narrow the results" })
    vim.keymap.set("n", "<C-\\>", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "Find open buffers" })
    vim.keymap.set("n", "<F1>", "<cmd>FzfLua help_tags<CR>", { silent = true, desc = "Search help" })
  end,
  opts = {}
}
