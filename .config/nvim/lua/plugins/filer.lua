-- TODO: これを試したい https://github.com/nvim-telescope/telescope-ui-select.nvim
-- TODO: これを試したい https://github.com/prochri/telescope-all-recent.nvim
return {
  -- ファイラ
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions
      telescope.setup({
        extensions = {
          file_browser = {
            hidden = true,
            mappings = {
              i = {
                ["<C-i>"] = fb_actions.toggle_respect_gitignore,
              },
            },
          },
        },
      })
      telescope.load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>f",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser (telescope)",
      },
    },
  },
  -- FuzzyFinder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = { "Telescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            height = 0.6,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-f>"] = actions.results_scrolling_down,
              ["<C-b>"] = actions.results_scrolling_up,
              ["<ESC>"] = actions.close,
            },
          },
          file_ignore_patterns = { "node_modules", "\\.git" },
          cache_picker = { num_pickers = 100 },
        },
        pickers = {
          find_files = { hidden = true },
          grep_string = { additional_args = { "--hidden" } },
          live_grep = { additional_args = { "--hidden" } },
        },
      })
    end,
    keys = {
      -- git管理下のファイル一覧
      {
        "<C-p>",
        function()
          require("telescope.builtin").git_files()
        end,
      },
      --      {
      --        '<C-p>',
      --        '<C-r>=v:lua.require("telescope.builtin").find_files()<CR>',
      --        mode = 'c',
      --      },
      -- ファイル一覧
      {
        "<leader>F",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files (telescope)",
      },
      -- Grep
      {
        "<leader>g",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep (telescope)",
      },
      -- 過去の結果を再表示
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").pickers()
        end,
        desc = "Pickers History (telescope)",
      },
      -- Grep
      {
        "<leader>t",
        function()
          require("telescope.builtin").grep_string({ search = "TODO" .. ":" })
        end,
        desc = "TODO Search (telescope)",
      },
    },
  },
}
