return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show errors and warnings on this line"
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

      opts.desc = "Show type and documentation"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Go to definition"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      -- Code (<leader>c): easier-to-find versions of Neovim's built-in gra / grn / gO
      opts.desc = "Code action"
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Rename symbol"
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

      opts.desc = "Symbols in this file"
      vim.keymap.set("n", "<leader>cs", "<cmd>FzfLua lsp_document_symbols<CR>", opts)

      opts.desc = "Symbols in the project"
      vim.keymap.set("n", "<leader>cS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", opts)
    end

    vim.lsp.config("sourcekit", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("sourcekit")

    -- nice icons
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })
  end,
}
