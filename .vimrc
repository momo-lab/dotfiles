" encoding/fileformat settings {{{
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
  set fileformat=unix
  set fileformats=unix,dos,mac
" }}}
" 各種パス設定 {{{
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  let s:vimrc = resolve(expand($MYVIMRC))
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

syntax on                           " syntax on
filetype plugin indent on           " ファイルタイプ毎のplugin, indent設定を読み込む
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
set autoindent
set smartindent
set expandtab
let s:tabstop = {
      \ '*': 4,
      \ 'vim': 2,
      \ 'coffee': 2,
      \ 'html': 2,
      \ 'ruby': 2,
      \ 'eruby': 2,
      \ 'scss': 2,
      \ 'zsh': 2,
      \ 'yaml': 2,
      \ 'toml': 2,
      \ 'gitconfig': 2,
      \ 'sh': 2,
      \ }
function! s:settabstop()
  let tabstop = s:tabstop['*']
  if has_key(s:tabstop, &filetype)
    let tabstop = s:tabstop[&filetype]
  endif
  exec "setlocal tabstop=" . tabstop . " shiftwidth=" . tabstop . " softtabstop=" . tabstop
endfunction
augroup vimrc_indent
  autocmd!
  autocmd BufRead,BufNewFile * call s:settabstop()
augroup END

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
exec 'nnoremap <F6> :<C-u>tabedit ' . s:vimrc . '<CR>'
exec 'nnoremap <F5> :<C-u>source ' . s:vimrc . '<CR>'

let s:vimrc_secret=expand('$HOME/.vimrc_secret')
if filereadable(s:vimrc_secret)
  exec 'source ' . s:vimrc_secret
endif

" translate-shellを使う
let s:trans_cmd = 'trans'
let s:trans_opt = '-b --no-ansi -e google'
exec 'command! -nargs=0 -range Trans <line1>,<line2>!' . s:trans_cmd . ' ' . s:trans_opt
nnoremap <silent> <F3> :Trans<CR>


" vim:fdm=marker:ts=2
