" エンコーディング指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

" ステータス行
set laststatus=2

set background=dark                 " 背景は黒ベース
set t_Co=256                        " カラー設定
set nobackup                        " backupファイルを作らない
set noswapfile                      " swapファイルを作らない
set hidden                          " 保存していないファイルがあってもファイルを開く
set number                          " 行番号を表示
set title                           " ウィンドウタイトルにファイル名を表示
set clipboard& clipboard+=unnamed   " Yankしたらクリップボードへ
set visualbell t_vb=                " ESCのビープ音を消す

" 不可視文字
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

" タブ
function! s:setlocaltab(index)
  exec "setlocal tabstop=" . a:index . " shiftwidth=" . a:index . " softtabstop=" . a:index
endfunction
augroup vimrc_tab
  autocmd!
  autocmd FileType vim call s:setlocaltab(2)
augroup END
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set expandtab

" ヘルプは q で閉じる
augroup vimrc_close
  autocmd!
  autocmd FileType help nnoremap <buffer> q <C-w>c
augroup END

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
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Git 用
Plug 'tpope/vim-fugitive'     " :Gwrite, :Gdiff, :GcommitなどGで始まるコマンドを提供
                              " 現在のバッファに対するgit操作を行う
Plug 'airblade/vim-gitgutter' " gitの差分を左端に表示する
Plug 'cohama/agit.vim'        " :Agitでgitのログを見る

" CoffeeScript 用
Plug 'kchmck/vim-coffee-script' " CoffeeScript用syntax highlight

" ステータスライン強化
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'

call plug#end()

" .vimrcを開く
nnoremap <F6> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F5> :<C-u>source $MYVIMRC<CR>
