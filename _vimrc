" Header {{{
" vim: foldmethod=marker
" [前提]
" * vimprocが導入されていること
" * C/Migemoが導入されていること
" -> 要は香り屋前提…

if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif
" }}}
" エンコーディング指定 {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
" }}}
" ステータス行の表示と指定 {{{
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" }}}
" backup/swpファイル設定 {{{
set nobackup
set noswapfile
"set backupdir=$TMP
"set directory=$TMP
" }}}

" backspaceの挙動変更
set backspace=indent,eol,start

" Yankしたらクリップボードへ
set clipboard& clipboard+=unnamed

" join時の空白の付与方法を変更(前後がマルチバイトなら空白なし)
set formatoptions& formatoptions+=B

" 行番号を表示
set number

" タブ文字は半角スペース2つ
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab

" 記号を入力するとカーソル位置がずれる問題の解消
if exists("&ambiwidth")
  set ambiwidth=double
endif

" ウィンドウ分割時は右側、下側に足す
set splitright
set splitbelow

" ウィンドウタイトルにファイル名を表示
set title

" ヘルプは q で閉じる
augroup vimrc-close
  autocmd!
  autocmd FileType help nnoremap <buffer> q <C-w>c
augroup END

" 不可視文字を可視化 {{{
set list
function! s:ChangeFileFormat()
  " TODO 「:set ff=xxx」したら自動でこの関数を呼びたいが…
  if &fileformat == "dos"
    set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  elseif &fileformat == "unix"
    set listchars=tab:»-,trail:-,eol:⇂,extends:»,precedes:«,nbsp:%
  elseif &fileformat == "mac"
    set listchars=tab:»-,trail:-,eol:↼,extends:»,precedes:«,nbsp:%
  endif
endfunction
call s:ChangeFileFormat()
augroup vimrc-changefileformat
  autocmd!
  autocmd BufEnter * :call s:ChangeFileFormat()
augroup END
" }}}

" キーマップ {{{
  " ViViっぽく
  " redoをUに
  nnoremap U <C-r>
  " vvで単語選択
  nnoremap vv viw

  " 折り畳み
  nnoremap zz za

  nnoremap q <Nop>
  nnoremap Q q
" }}}

" プラグイン読込(NeoBundle)

set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  if has('win32') || has('win64')
    set runtimepath^=~/.vim/
  endif
endif

call neobundle#rc(expand('~/.vim/bundle/'))
let g:neobundle_default_git_protocol='http'
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'surround.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'deris/vim-rengbang'

NeoBundle 'airblade/vim-rooter' " {{{
  " 以下の優先順でカレントファイル変更時にディレクトリ移動する
  " * カレントファイルのルートディレクトリ
  " * カレントファイルのディレクトリ
  let g:rooter_manual_only = 1
  let g:rooter_use_lcd = 1
  function! s:MyChangeToRootDirectory()
    let save_cwd = getcwd()
    try
      execute ":Rooter"
    catch
    endtry
    if save_cwd == getcwd()
      try
        lcd %:p:h
      catch
      endtry
    endif
   if save_cwd != getcwd()
      echo "Change Directory to " . getcwd()
    endif
  endfunction
  augroup rooter
    autocmd!
    autocmd BufEnter * :call s:MyChangeToRootDirectory()
  augroup END
" }}}

NeoBundle 'Shougo/unite.vim' " {{{
  NeoBundle 'osyo-manga/unite-qfixhowm'
  NeoBundle 'tsukkee/unite-help'
  NeoBundle 'kmnk/vim-unite-giti'

  let unite_split_rule = 'botright'
  let g:unite_enable_start_insert = 1
  let g:unite_enable_short_source_names = 1

  " unite-grepのバックエンドをagに切り替える
  " http://qiita.com/items/c8962f9325a5433dc50d
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
  endif

  " Uniteのキーマップ {{{
  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    " <ESC>連打で終了
    nmap <buffer> <ESC>   <Plug>(unite_exit)
    " j or k連打で行移動できるようにする
    imap <buffer> jj      <Plug>(unite_insert_leave)
    imap <buffer> kk      <Plug>(unite_select_previous_line)<Plug>(unite_insert_leave)
    imap <buffer> <C-j>   <Plug>(unite_insert_leave)
    nmap <buffer> <C-j>   <Plug>(unite_select_next_line)
    " 1ワード削除(インサートモードと同じ挙動になるようにする)
    nmap <buffer> <C-w>   <Plug>(unite_delete_backspace_word)
    " 既に入力されている文字を削除した状態で入力
    nmap <buffer> I       <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
    nmap <buffer> <C-u>   <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
  endfunction
  " }}}

  nnoremap [unite] <Nop>
  nmap <Space> [unite]

  " 検索方法を指定
  call unite#custom#source('file', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('file_mru', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('bookmark', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('buffer', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('qfixhowm', 'matchers', 'matcher_migemo')
  call unite#custom#source('help', 'matchers', 'matcher_fuzzy')

  " 前回のUnite結果を再表示
  nnoremap <silent> [unite]<Space> :<C-u>UniteResume<CR>

  " カレントディレクトリのファイルを表示
  nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=carrent_files file file_mru bookmark<CR>

  " カレントバッファのディレクトリのファイルを表示
  nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir -buffer-name=buffer_files file file_mru bookmark<CR>

  " カレントディレクトリでgrep
  nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep -no-empty grep:.<CR>

  " ディレクトリを指定してgrep
  nnoremap <silent> [unite]G :<C-u>Unite -buffer-name=grep -no-empty grep<CR>

  " QFixHowmのリストを表示
  nnoremap <silent> [unite], :<C-u>Unite -buffer-name=howm -hide-source-names qfixhowm/new qfixhowm:nocache<CR>

  " メニュー表示
  let vimrc = expand("$HOME/dotfiles/_vimrc")
  if !filereadable(vimrc)
    let vimrc = expand("$MYVIMRC")
  endif
  let gvimrc = expand("$HOME/dotfiles/_gvimrc")
  if !filereadable(gvimrc)
    let gvimrc = expand("$MYGVIMRC")
  endif
  let g:unite_source_menu_menus = {
  \   "shortcut": {
  \     "description": "Unite Menu",
  \     "command_candidates": [
  \       ["edit .vimrc [" . vimrc . "]", "tabedit " . vimrc],
  \       ["load .vimrc [" . vimrc . "]", "source " . vimrc],
  \       ["edit .gvimrc [" . gvimrc . "]", "tabedit " . gvimrc],
  \       ["load .gvimrc [" . gvimrc . "]", "source " . gvimrc],
  \     ],
  \   },
  \ }
  nnoremap <silent> [unite]m :<C-u>Unite menu:shortcut<CR>

  " ヘルプ表示
  nnoremap <silent> [unite]h :<C-u>Unite help<CR>
" }}}

NeoBundle 'fuenor/qfixhowm.git' " {{{
  let QFixHowm_Key = ','
  let howm_dir = '$HOME/howm'
  let howm_filename = '%Y/%m/%d-%H%M%S.howm'
  let howm_fileencoding = 'utf-8'
  let howm_fileformat = 'dos'
  let QFixHowm_ListCloseOnJump = 1 " なぜか効果なし…(T-T)
  let QFixHowm_MenuPreview = 0
" }}}

NeoBundle 'Shougo/vimshell' " {{{
  let g:vimshell_prompt_expr = 'fnamemodify(getcwd(), ":~")."> "'
  let g:vimshell_prompt_pattern = '^\f\+> '
" }}}

NeoBundle 'kana/vim-submode' " {{{
let g:submode_keep_leaving_key = 1

" タブの切り替え
call submode#enter_with('tabpage', 'n', '', 'gt', 'gt')
call submode#enter_with('tabpage', 'n', '', 'gT', 'gT')
call submode#map('tabpage', 'n', '', 't', 'gt')
call submode#map('tabpage', 'n', '', 'T', 'gT')

" ウィンドウのリサイズ
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
" }}}

filetype plugin indent on

