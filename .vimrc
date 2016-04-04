" 各種パス
let s:is_windows = has('win16') || has('win32') || has('win64')
if s:is_windows
  let $DOTVIM = expand('~/vimfiles')
else
  let $DOTVIM = expand('~/.vim')
endif
let $PLUGDIR = $DOTVIM . "/plugged"
"
" エンコーディング指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

" ステータス行
set laststatus=2
" gvimなら常にタブ表示
if has('gui')
  set showtabline=2
endif

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

" インデント
function! s:setlocaltab(index)
  exec "setlocal tabstop=" . a:index . " shiftwidth=" . a:index . " softtabstop=" . a:index
endfunction
augroup vimrc_tab
  autocmd!
  autocmd FileType vim call s:setlocaltab(2)
  autocmd FileType coffee call s:setlocaltab(2)
  autocmd FileType html call s:setlocaltab(2)
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

"プラグインの存在チェック
function! s:has_plugin(name)
  return has_key(g:plugs, a:name) ? isdirectory(g:plugs[a:name].dir) : 0
endfunction

"vim-plugの準備
let s:vim_plug_url = 'https://github.com/junegunn/vim-plug.git'
let s:vim_plug_path = $PLUGDIR . '/vim-plug'
if has('vim_starting')
  exec 'set rtp& rtp+=' . s:vim_plug_path
  if !isdirectory(s:vim_plug_path)
    echo 'install vim-plug...'
    call system('mkdir -p '. s:vim_plug_path)
    call system('git clone --depth 1 ' . s:vim_plug_url . ' ' . s:vim_plug_path . '/autoload')
  endif
endif

call plug#begin($PLUGDIR)

" vim-plug
Plug 'junegunn/vim-plug',
  \ {'dir': $PLUGDIR . '/vim-plug/autoload'}

" カラースキーマ
Plug 'w0ng/vim-hybrid'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|/.git/'

" Git 用
Plug 'tpope/vim-fugitive'     " :Gwrite, :Gdiff, :GcommitなどGで始まるコマンドを提供
                              " 現在のバッファに対するgit操作を行う
Plug 'airblade/vim-gitgutter' " gitの差分を左端に表示する
Plug 'cohama/agit.vim'        " :Agitでgitのログを見る

" HTML 用
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<c-y>'

" CoffeeScript 用
Plug 'kchmck/vim-coffee-script' " CoffeeScript用syntax highlight

" Snippets
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)


" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" Quickrun
Plug 'thinca/vim-quickrun'

" ステータスライン強化
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'

call plug#end()

" カラースキーマ
let g:mycolorscheme = 'desert'
if s:has_plugin('vim-hybrid')
  let g:mycolorscheme = 'hybrid'
endif
exec "colorscheme " . g:mycolorscheme

" .vimrcを開く
nnoremap <F6> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F5> :<C-u>source $MYVIMRC<CR>
