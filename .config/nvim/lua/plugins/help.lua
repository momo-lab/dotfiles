return {
  {
    -- キーバインドを表示
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      -- git管理下のファイル一覧
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
