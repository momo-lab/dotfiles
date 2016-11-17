" 各種パス設定 {{{
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
" }}}
" dein settings {{{
  if &compatible
    set nocompatible               " Be iMproved
  endif
  " dein自体の自動インストール
  let s:dein_dir = s:cache_home . '/dein'
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif
  " プラグイン読み込み＆キャッシュ作成
  let &runtimepath = s:dein_repo_dir .",". &runtimepath
  let s:toml_file = expand('$HOME/.vim/dein.toml')
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
  endif
  " 不足プラグインの自動インストール
  if has('vim_starting') && dein#check_install()
    call dein#install()
  endif
" }}}

" エンコーディング指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

syntax on														" syntax on
set background=dark                 " 背景は黒ベース
set t_Co=256                        " カラー設定
set nobackup                        " backupファイルを作らない
set noswapfile                      " swapファイルを作らない
set hidden                          " 保存していないファイルがあってもファイルを開く
set number                          " 行番号を表示
set title                           " ウィンドウタイトルにファイル名を表示
set visualbell t_vb=                " ESCのビープ音を消す
set modeline                        " modeline(末尾のvim:ts=2みたいなやつ)を有効にする

" clipboard
if has('clipboard')
  set clipboard& clipboard+=unnamed " Yankしたらクリップボードへ
endif

" undo
let s:undodir = s:cache_home . "/vim-undo"
if !isdirectory(s:undodir)
  call system('mkdir -p '. s:undodir)
endif
set undofile
exec "set undodir=" . s:undodir

" ステータス行
set laststatus=2
" gvimなら常にタブ表示
if has('gui_running')
  set showtabline=2
endif

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
  autocmd FileType ruby call s:setlocaltab(2)
  autocmd FileType eruby call s:setlocaltab(2)
  autocmd FileType scss call s:setlocaltab(2)
  autocmd FileType zsh call s:setlocaltab(2)
  autocmd FileType yaml call s:setlocaltab(2)
  autocmd FileType gitconfig call s:setlocaltab(2)
  autocmd FileType sh call s:setlocaltab(2)
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
" }}}

" .vimrcを開く
nnoremap <F6> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" vim:fdm=marker:ts=2
