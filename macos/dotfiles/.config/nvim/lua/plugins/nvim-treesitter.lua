return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main doesn't support lazy-loading
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.install({
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "lua",
        "gitignore",
        "swift",
      })

      -- main doesn't enable highlighting or auto-install parsers, so do both here
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
          elseif vim.tbl_contains(treesitter.get_available(), lang) then
            treesitter.install(lang):await(vim.schedule_wrap(function(err)
              if not err and vim.api.nvim_buf_is_valid(args.buf) then
                vim.treesitter.start(args.buf, lang)
              end
            end))
          end
        end,
      })
    end,
  },
}
