-- 編集機能系(入力補助とかカーソル移動補助とか)
return {
  -- *** 入力補助 ***
  -- コメントアウト
  {
    -- いったん標準の gc で対応してみる
    -- TODO: コメントアウト系プラグインを試す。以下が候補。
    -- https://github.com/folke/ts-comments.nvim
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    -- https://github.com/numToStr/Comment.nvim
  },
  -- カッコやクォートなどの自動入力
  {
    "kana/vim-smartinput",
    event = "VeryLazy",
  },
  -- ノーマルモードに戻ったら日本語入力をOFFにする
  {
    "kaz399/spzenhan.vim",
    event = { "BufEnter", "InsertEnter", "InsertLeave" },
    init = function()
      -- executableの指定をしないと実行ファイルを探すところでエラーになる
      local path = vim.fn.stdpath("data") .. "/lazy/spzenhan.vim/zenhan/spzenhan.exe"
      vim.g["spzenhan#executable"] = path
      vim.g["spzenhan#default_status"] = 0
    end,
  },

  -- *** Tree-Sitters(構文解析) ***
  -- TODO: typescriptreactを使えるようにしたい
  -- TODO: インデントが壊れるらしいのでこっちも試す https://github.com/yioneko/nvim-yati
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "javascript",
          "typescript", -- "typescriptreact",
          "html",
          "css",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- *** textobject ***
  -- Surround
  -- usage: s]   追加: xxx  -> [xxx]  (Visualモード)
  -- usage: cs]) 変更: [xxx] -> (xxx)
  -- usage: ds]  削除: [xxx] -> xxx
  -- usage: 追加/変更の時, 開きカッコは内側にスペースあり/閉じカッコはスペースなし
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        visual = "s",
        visual_line = "gs",
      },
    },
  },
  -- treesitterを使ってテキストオブジェクトのパターンを増やす
  -- usage: , でパラメータを選択
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["i,"] = "@parameter.inner",
              ["a,"] = "@parameter.outer",
            },
          },
        },
      })
    end,
  },
  -- テキストオブジェクトの範囲を拡大/縮小
  -- TODO: 使うほうだけ残す
  -- usage: 範囲選択後vとVで拡大/縮小(nvim-treesitter-textsubjects)
  -- usage: <CR>と<BS>で選択範囲の拡大/縮小(wildfire.nvim)
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        textsubjects = {
          enable = true,
          prev_selection = "V",
          keymaps = {
            ["v"] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
      })
    end,
  },
  {
    "https://github.com/SUSTech-data/wildfire.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {},
    -- TODO: <CR>以外の方法でビジュアルモードになると、incrでエラーが出るのをどうにかしたい
    -- ビジュアルモードになったらinit_selectionする、というのを試してみたが意図する挙動にはならなかった
    -- vim.api.nvim_create_autocmd("ModeChanged", {
    --   pattern = { "*:[vV\x16]*" },
    --   callback = function(ev)
    --     require("wildfire").init_selection()
    --   end,
    -- })
  },

  -- *** 見た目の改善 ***
  -- インデントの可視化
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = { enable = true },
      indent = { enable = true },
    },
  },
  -- 文字幅の調整
  {
    "rbtnn/vim-ambiwidth",
  },
}
