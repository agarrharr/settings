return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Jump between changed blocks (hunks)
      map("n", "]h", function() gitsigns.nav_hunk("next") end, "Next git change")
      map("n", "[h", function() gitsigns.nav_hunk("prev") end, "Previous git change")

      -- Act on the change under the cursor (or the selected lines)
      map("n", "<leader>gp", gitsigns.preview_hunk, "Preview git change")
      map("n", "<leader>gs", gitsigns.stage_hunk, "Stage/unstage git change")
      map("n", "<leader>gr", gitsigns.reset_hunk, "Discard git change")
      map("v", "<leader>gs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selected lines")
      map("v", "<leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Discard selected lines")
      map("n", "<leader>gS", gitsigns.stage_buffer, "Stage file")
      map("n", "<leader>gR", gitsigns.reset_buffer, "Discard all changes in file")

      -- Blame
      map("n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, "Blame current line")
      map("n", "<leader>gB", gitsigns.toggle_current_line_blame, "Toggle inline blame")

      -- "ih" selects the change under the cursor, e.g. vih or dih
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git change")
    end,
  },
}
