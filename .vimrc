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

" タブ
function! s:setlocaltab(index)
  exec "setlocal tabstop=" . a:index . " shiftwidth=" . a:index . " softtabstop=" . a:index
endfunction
augroup vimrc
  autocmd! FileType vim call s:setlocaltab(2)
augroup END
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set expandtab

" Yankしたらクリップボードへ
set clipboard& clipboard+=unnamed

" ViViっぽくする
" redoをUに
nnoremap U <C-r>
" vvで単語選択
nnoremap vv viw
" 折り畳み
nnoremap zz za

call plug#begin('~/.vim/plugged')

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Git 用
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ステータスライン強化
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'
"let g:lightline = {
"    \ 'colorscheme': 'wombat'
"    \ }

call plug#end()

" .vimrcを開く
nnoremap <F5> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>
