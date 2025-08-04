return {
  -- LSPのサーバをインストール
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstAll", "MasonUpdate" },
    config = true,
  },
  -- LSP系のツールをインストール
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "nvimdev/lspsaga.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    keys = {
      -- エラー箇所に移動
      { "ge", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics(lspsaga)" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Jump prev diagnostics(lspsaga)" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Jump next diagnostics(lspsaga)" },

      { "<C-space>", "<cmd>lua vim.lsp.completion.get()<CR>", mode = "i" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover(lspsaga)" },
      { "gd", "<cmd>Lspsaga peek_definition<CR>", "Go to definition(lspsaga)" },
      { "gR", "<cmd>Lspsaga rename<CR>", "Rename(lspsaga)" },
    },
  },
  -- Linter/Formatter
  -- * biomeの設定があればそれを優先。無ければprettierを使う。
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    config = function()
      local biome_root_file = require("conform.util").root_file({
        "biome.json",
        "biome.jsonc",
      })
      require("conform").setup({
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          json = { "biome", "prettier" },
          javascript = { "biome-organize-imports", "biome", "prettier" },
          typescript = { "biome-organize-imports", "biome", "prettier" },
          yaml = { "biome", "prettier" },
          css = { "biome", "prettier" },
          markdown = { "biome", "prettier" },
        },
        formatters = {
          biome = {
            cwd = biome_root_file,
            require_cwd = true,
          },
          prettier = {
            condition = function(self, ctx)
              local root = biome_root_file(self, ctx)
              return root == nil
            end,
          },
        },
      })
    end,
  },
  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(_, vim_item)
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
  -- LSPアイコン
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
    opts = {},
  },
  -- 見た目の改善
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = { "Bufread", "BufNewFile" },
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,
          sign = false,
        },
        definition = {
          keys = {
            edit = "o",
          },
        },
      })
    end,
  },
  -- diagnosticsのリストをトグル表示したり。
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        diagnostics = {
          auto_close = true,
          auto_open = true,
        },
      },
    },
    cmd = "Trouble",
    event = "VeryLazy",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
