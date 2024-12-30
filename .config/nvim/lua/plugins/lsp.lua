-- LSP Server List
local lsp_servers = {
  "lua_ls",
  "ts_ls",
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
      local lsp_config = require("lspconfig")
      for _, lsp_server in ipairs(lsp_servers) do
        lsp_config[lsp_server].setup({
          root_dir = function(fname)
            return lsp_config.util.find_git_ancestor(fname) or vim.fn.getcwd()
          end,
        })
      end
      lsp_config.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = {'vim'} },
          },
        },
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = keymappings,
      })
    end,
  },
  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    event = "VeryLazy",
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
