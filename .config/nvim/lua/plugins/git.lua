return {
  -- Gitの変更を表示とStagingなどの操作
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = true,
      numhl = true,
      word_diff = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        -- TODO: サンプルそのままなので使うものとそうじゃないものに分けること
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk(gitsigns)" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk(gitsigns)" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk(gitsigns)" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk(gitsigns)" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer(gitsigns)" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk(gitsigns)" })
        map("n", "<leader>hU", gitsigns.reset_buffer_index, { desc = "Unstage buffer(gitsigns)" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer(gitsigns)" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk(gitsigns)" })
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame line(gitsigns)" })
        -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this(gitsigns)" })
        -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        -- map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
}
