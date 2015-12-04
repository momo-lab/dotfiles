" カラー設定
set t_Co=256

" エンコーディング指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

" ステータス行
set laststatus=2

" backup / swp を作らない
set nobackup
set noswapfile

" 行番号を表示
set number

" タブ文字は半角スペース2つ
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set expandtab

" Yankしたらクリップボードへ
set clipboard& clipboard+=unnamed

" ViViっぽくする {{{
" redoをUに
nnoremap U <C-r>
" vvで単語選択
nnoremap vv viw

" 折り畳み
nnoremap zz za
" }}}

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'

Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'wombat'
    \ }

call plug#end()

