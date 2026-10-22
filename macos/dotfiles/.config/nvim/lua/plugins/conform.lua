return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
      -- format_on_save = function()
      --   return { timeout_ms = 500, lsp_fallback = true }
      -- end,
      log_level = vim.log.levels.ERROR,
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file (or selection)" })
  end,
}
