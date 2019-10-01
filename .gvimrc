" フォント設定
set guifont=MS_Gothic:h9

" ツールバー＆メニューを非表示
set guioptions& guioptions-=m guioptions-=T

" ウィンドウサイズ
set columns=150
set lines=51

" カラー設定 {{{
"  syntax on
  set background=dark
"  exec "colorscheme " . g:mycolorscheme
"  colorscheme desert

  " 空白文字を目立たなくする
  highlight NonText    guifg=darkgray guibg=NONE gui=NONE
  highlight SpecialKey guifg=darkgray guibg=NONE gui=NONE
" }}}

