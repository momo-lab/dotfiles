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
  -- * oxfmt, biome, prettierは見つかったものを使う
  -- * biome-organize-importsは動くか微妙
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    config = function()
      local js_formatter = {
        "oxfmt",
        "biome-organize-imports",
        "biome",
        "prettier",
        stop_after_first = true,
      }
      vim.api.nvim_create_user_command("FormatDisable", function()
        vim.b.disable_autoformat = true
      end, { desc = "Disable format_on_save for current buffer" })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
      end, { desc = "Enable format_on_save for current buffer" })
      require("conform").setup({
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return {
            timeout_ms = 1000,
            lsp_fallback = true,
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          json = js_formatter,
          jsonc = js_formatter,
          javascript = js_formatter,
          typescript = js_formatter,
          javasjavascript = js_formatter,
          typescriptreact = js_formatter,
          ycss = js_formatter,
          css = js_formatter,
          hcss = js_formatter,
          markdcss = js_formatter,
        },
      })
    end,
  },
  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "zbirenbaum/copilot-cmp",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "buffer" },
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
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
  -- github copilotの補完
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = "node",
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- copilot chat
  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
        language = "Japanese",
      },
    },
  },
  -- LSPアイコン
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
    opts = {
      symbol_map = {
        Copilot = "",
      },
    },
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
          auto_close = false,
          auto_open = false,
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
