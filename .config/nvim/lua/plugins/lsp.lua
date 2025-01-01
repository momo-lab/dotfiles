-- LSP Server List
local lsp_servers = {
  "lua_ls",
  "ts_ls", -- for typescript
  "yamlls",
  "html",
  "cssls",
}

local formatters = {
  "stylua", -- for lua
  "prettier", -- for yaml, typescript, css
}

local diagnostics = {
  "yamllint",
}

-- キーマッピング
local function keymappings(ev)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      desc = desc,
      buffer = ev.buf,
    })
  end
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "K", vim.lsp.buf.hover, "Hover")
end

return {
  -- LSP系のツールをインストール
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
      })

      -- 全体設定
      local lsp_config = require("lspconfig")
      vim.iter(lsp_servers):each(function(server)
        lsp_config[server].setup({
          root_dir = function(fname)
            return lsp_config.util.find_git_ancestor(fname) or vim.fn.getcwd()
          end,
        })
      end)

      -- 個別設定
      lsp_config.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- キーマッピング定義
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = keymappings,
      })
    end,
  },
  -- Linter/Formatter
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    cmd = "Mason",
    config = {
      automatic_setup = true,
      ensure_installed = vim.iter({ formatters, diagnostics }):flatten():totable(),
      handlers = {},
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lsp-format").setup()
      local null_ls = require("null-ls")

      local formatting_sources = vim
        .iter(formatters)
        :map(function(tool)
          return null_ls.builtins.formatting[tool]
        end)
        :totable()
      local diagnostics_sources = vim
        .iter(diagnostics)
        :map(function(tool)
          return null_ls.builtins.diagnostics[tool]
        end)
        :totable()

      null_ls.setup({
        sources = vim.iter({ formatting_sources, diagnostics_sources }):flatten():totable(),
        -- 保存時に自動フォーマット
        on_attach = require("lsp-format").on_attach,
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
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
      })
    end,
  },
  -- LSPアイコン
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
  },
}
