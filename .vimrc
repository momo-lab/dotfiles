" 各種パス
let s:is_windows = has('win32') || has('win64')
let $DOTVIM = expand('~/.vim')
set rtp&
if s:is_windows
  " $HOME/vimfilesを$HOME/.vimに変更
  let s:rtp = substitute(&rtp,
        \ substitute(expand($HOME).'/vimfiles', '\\', '\\\\', 'g'),
        \ substitute(expand($HOME).'/.vim', '\\', '\\\\', 'g'),
        \ 'g')
  exec 'set rtp='.s:rtp
endif

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

" 除外ファイル指定
if s:is_windows
  set wildignore=*\\vendor\\bundle\\*,*\\node_modules\\*,*\\.DS_Store,*\\.git\\*,*\\.svn\\*,*.cache
else
  set wildignore=*/vendor/bundle/*,*/node_modules/*,*/.DS_Store,*/.git/*,*/.svn/*,*.cache
endif

" undo
let s:undodir = $DOTVIM . "/undo"
if !isdirectory(s:undodir)
  call system('mkdir -p '. s:undodir)
endif
set undofile
exec "set undodir=" . s:undodir

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

"プラグインの存在チェック
function! s:has_plugin(name)
  return has_key(g:plugs, a:name) ? isdirectory(g:plugs[a:name].dir) : 0
endfunction

call plug#begin($DOTVIM.'/plugged')

" 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'
set helplang=ja

" カラースキーマ
Plug 'w0ng/vim-hybrid'

" Unite.vim
Plug 'Shougo/vimproc', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
let unite_split_rule = 'botright'
let g:unite_enable_start_insert = 0
let g:unite_enable_short_source_names = 1
let g:unite_source_menu_menus = {}
" unite-grepのバックエンドをptに切り替える
" http://qiita.com/items/c8962f9325a5433dc50d
let g:unite_source_grep_encoding = 'utf-8'
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 200
endif
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " <ESC>連打で終了
  nmap <buffer> <ESC>   <Plug>(unite_exit)
  imap <buffer> <ESC><ESC>   <Plug>(unite_exit)
  " Ctrl+J/Kで選択
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " 1ワード削除(インサートモードと同じ挙動になるようにする)
  nmap <buffer> <C-w>   <Plug>(unite_delete_backspace_word)
  " 既に入力されている文字を削除した状態で入力
  nmap <buffer> I       <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
  nmap <buffer> <C-u>   <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
endfunction
nnoremap [unite] <Nop>
nmap <Space> [unite]
" 前回のUnite結果を再表示
nnoremap <silent> [unite]<Space> :<C-u>UniteResume<CR>
" ソースを選択
nnoremap <silent> [unite]s :<C-u>Unite source<CR>
" カレントディレクトリ配下のファイルを表示
nnoremap <silent> [unite]f :<C-u>Unite file_rec<CR>
" git管理のファイルを表示
nnoremap <silent> <C-p> :<C-u>Unite file_rec/git -start-insert<CR>
" Grep
nnoremap <silent> [unite]g :<C-u>Unite grep:. -no-empty<CR>

" Vimfiler
Plug 'Shougo/vimfiler.vim'
let g:vimfiler_as_default_explorer = 1

" Git 用
Plug 'tpope/vim-fugitive'     " :Gwrite, :Gdiff, :GcommitなどGで始まるコマンドを提供
                              " 現在のバッファに対するgit操作を行う
Plug 'airblade/vim-gitgutter' " gitの差分を左端に表示する
Plug 'cohama/agit.vim'        " :Agitでgitのログを見る

" Gist 用
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gista-unite'
let g:gista#command#list#default_opener = 'botright 15 split'
let g:gista#command#post#default_public = 0
autocmd FileType gista-list call s:gista_list_mappings()
function! s:gista_list_mappings()
  nmap <buffer> <ESC> <Plug>(gista-quit)
endfunction

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
let g:quickrun_config = {
            \ 'ruby': { 'command': 'bundruby' }
            \ }

" 検索関連
Plug 'osyo-manga/vim-anzu'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/incsearch.vim'
set ignorecase
set smartcase
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)<Plug>(anzu-update-search-status)
map N  <Plug>(incsearch-nohl-N)<Plug>(anzu-update-search-status)
map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)<Plug>(anzu-update-search-status)
map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)<Plug>(anzu-update-search-status)
map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)<Plug>(anzu-update-search-status)
map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)<Plug>(anzu-update-search-status)
augroup vim-anzu
  " カーソルが移動したとき(CursorMoved)、一定時間キー入力がないとき(CursorHold,CursorHoldI)、
  " ウインドウを移動したとき(WinLeave)、タブを移動したとき(TabLeave)に
  " 検索ヒット数の表示を消去する
  autocmd!
  autocmd CursorMoved,CursorHold,CursorHoldI,WinLeave,TabLeave *
        \ call anzu#clear_search_status()
augroup END

" ステータスライン強化
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'

Plug 'renumber.vim'

" Github issue操作
Plug 'jaxbot/github-issues.vim'
Plug 'momo-lab/github_auth.vim'
let g:github_issues_no_omni = 1

" Vim script開発用
Plug 'vim-jp/vital.vim'
Plug 'lambdalisue/vital-Web-API-GitHub'

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
