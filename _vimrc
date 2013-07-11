"  Header
  " vim: foldmethod=marker
  " [前提]
  " * vimprocが導入されていること
  " * C/Migemoが導入されていること
  " -> 要は香り屋前提…
" 
"  プラグイン読込(NeoBundle)
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
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-smartword'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
"NeoBundle 'kien/ctrlp.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'osyo-manga/unite-qfixhowm'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'fuenor/qfixhowm.git'
NeoBundle 'airblade/vim-rooter'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'rking/ag.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'kana/vim-submode'
NeoBundle 'deris/vim-rengbang'

filetype plugin on
filetype indent on
" 
"  全体設定
  " エンコーディング指定
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
  set fileformat=unix
  set fileformats=unix,dos,mac

  " ステータス行の表示と指定
  set laststatus=2
  set statusline=%<%f\ %m%r%h%w
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
  set statusline+=%=%l/%L,%c%V%8P

  " backup/swpファイルの作成先を指定
  set nobackup
  set noswapfile
  "set backupdir=$TMP
  "set directory=$TMP

  " backspaceの挙動変更
  set backspace=indent,eol,start

  " Yankしたらクリップボードへ
  set clipboard& clipboard+=unnamed

  " join時の空白の付与方法を変更(前後がマルチバイトなら空白なし)
  set formatoptions& formatoptions+=B

" 
"  バッファ設定
  " 行番号を表示
  set number

  " タブ文字は半角スペース2つ
  set tabstop=2
  set shiftwidth=2
  set autoindent
  set expandtab

  " 不可視文字を可視化
  set list
  set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

  " 記号を入力するとカーソル位置がずれる問題の解消
  if exists("&ambiwidth")
    set ambiwidth=double
  endif

  "  キーマップ
    " ViViっぽく
    " redoをUに
    nnoremap U <C-r>
    " vvで単語選択
    nnoremap vv viw

    " 折り畳み
    nnoremap zz za

    nnoremap q <Nop>
    nnoremap Q q
  " 
" 
"  ウィンドウ設定
  " ウィンドウ分割時は右側、下側に足す
  set splitright
  set splitbelow
" 
"  タブ設定
" 
"  プラグイン設定: vim-rooter
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
" 
"  プラグイン設定: QFixHowm
  let QFixHowm_Key = ','
  let howm_dir = '$HOME/howm'
  let howm_filename = '%Y/%m/%d-%H%M%S.howm'
  let howm_fileencoding = 'utf-8'
  let howm_fileformat = 'dos'
  let QFixHowm_ListCloseOnJump = 1 " なぜか効果なし…(T-T)
  let QFixHowm_MenuPreview = 0
" 
"  プラグイン設定: Unite.vim
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

  "  Uniteのキーマップ
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
  " 

  nnoremap [unite] <Nop>
  nmap <Space> [unite]

  " 前回のUnite結果を再表示
  nnoremap <silent> [unite]<Space> :<C-u>UniteResume<CR>

  call unite#custom#source('file', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('file_mru', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('bookmark', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('buffer', 'matchers', 'matcher_fuzzy')

  " カレントディレクトリのファイルを表示
  nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir
    \ -buffer-name=carrent_files
    \ buffer file file_mru bookmark<CR>

  " カレントバッファのディレクトリのファイルを表示
  nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
    \ -buffer-name=buffer_files
    \ buffer file file_mru bookmark<CR>

  " QFixHowmのリストを表示
  call unite#custom#source('qfixhowm', 'matchers', 'matcher_migemo')
  nnoremap <silent> [unite], :<C-u>Unite
    \ -buffer-name=howm
    \ -hide-source-names
    \ qfixhowm/new qfixhowm:nocache<CR>

  " メニュー表示
  let g:unite_source_menu_menus = {
  \   "shortcut": {
  \     "description": "Unite Menu",
  \     "command_candidates": [
  \       ["edit .vimrc" , "tabedit $MYVIMRC"],
  \       ["load .vimrc",  "source $MYVIMRC"],
  \       ["edit .gvimrc", "tabedit $MYGVIMRC"],
  \       ["load .gvimrc",  "source $MYGVIMRC"],
  \     ],
  \   },
  \ }
  nnoremap <silent> [unite]m :<C-u>Unite
    \ menu:shortcut<CR>

  " ヘルプ表示
  call unite#custom#source('help', 'matchers', 'matcher_fuzzy')
  nnoremap <silent> [unite]h :<C-u>Unite
    \ help<CR>
" 
" smartword.vim {{{
"map w <Plug>(smartword-w)
"map b <Plug>(smartword-b)
"map e <Plug>(smartword-e)
"map ge <Plug>(smartword-ge)
"noremap ,w w
"noremap ,b b
"noremap ,e e
"noremap ,ge ge
" }}}
" submode.vim {{{
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
