" Encoding {{{
"=============
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
filetype plugin indent on
" }}}

" 基本設定 {{{
"=============
set scrolloff=5                "カーソルの上下の最低行数
set wrap                       "行折り返し
set breakindent                "行折り返しでインデントを考慮
set nobackup                   "上書き時バックアップ作成禁止
set autoread                   "書き換え時，自動で読みなおす
set noswapfile                 "swapファイル作成禁止
set hidden                     "保存しないで他のファイルを編集可能に
set backspace=indent,eol,start "BSで文字を消せるように
set clipboard=unnamed          "OSのクリップボード使用
set ruler                      "現在地の表示
set number                     "行番号表示
set showmatch                  "(),{}のお知らせ
set matchtime=1                "showmatchを0.1s
set cursorline                 "ライン強調
set laststatus=2               "ステータスラインの設定
set statusline=%f%m%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set nrformats=alpha,hex        "<C-a>と<C-x>での増減について，8進却下・英字許可
set foldmethod=marker          "markerで自動折りたたみ可能
set pumheight=10

" 不可視文字の設定
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:%   "各種特殊文字の文字
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue  "全角スペースの色
au BufRead,BufNew * match JpSpace /　/                     "全角スペース怖い
set display=uhex                                           "バイナリファイルの非印字可能文字を16進数で表示
" }}}

" 検索設定 {{{
"=============
set ignorecase                "小文字検索で大文字ヒット
set smartcase                 "大文字を含む場合は厳密に
set incsearch                 "インクリメンタルサーチ
set nowrapscan                "
set whichwrap=b,s,h,l,<,>,[,] "
set history=1000              "コマンド、検索パターンを100個まで履歴に残す
" }}}

" インデント・タブスペース {{{
"=============================
set autoindent
set expandtab
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set tabstop=4
" }}}

" Binary Editor {{{
"==================
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END
" }}}

" Extension Settings {{{
"=======================
au BufRead,BufNewFile *.md set filetype=markdown
" }}}

" neobundle {{{
"===============
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundleがなければclone
if !filereadable(expand('~/.vim/bundle/neobundle.vim/README.md'))
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Color
NeoBundle 'w0ng/vim-hybrid'

" Common
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc.vim', {
\   'build' : {
\       'windows' : 'tools\\update-dll-mingw',
\       'cygwin' : 'make -f make_cygwin.mak',
\       'mac' : 'make -f make_mac.mak',
\       'unix' : 'make -f make_unix.mak',
\   },
\}

" Unite
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/unite.vim', { 'autoload' : { 'commands' : [ "Unite" ] } }
NeoBundleLazy 'osyo-manga/unite-github', { 'autoload' : { 'commands' : [ "Unite" ] } }
NeoBundleLazy 'h1mesuke/unite-outline', { 'autoload' : { 'commands' : [ "Unite" ] } }

NeoBundleLazy 'kana/vim-altr'
NeoBundle 'Yggdroot/indentLine'

" Quickrun関係
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'rhysd/wandbox-vim'

" C++
NeoBundle 'vim-jp/cpp-vim', { 'autoload' : { 'filetypes' : ['cpp'] }}
NeoBundle 'justmao945/vim-clang', { 'autoload' : { 'filetypes' : ['cpp'] }}

" Haskell
NeoBundleLazy 'eagletmt/ghcmod-vim', { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'eagletmt/neco-ghc', { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'kana/vim-filetype-haskell', { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'dag/vim2hs', { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'pbrisbin/vim-syntax-shakespeare', { 'autoload' : { 'filetypes' : ['haskell'] }}

" Lisp
NeoBundleLazy 'vim-scripts/slimv.vim', { 'autoload' : { 'filetypes' : ['lisp'] }}

" HTML
NeoBundleLazy 'amirh/HTML-AutoCloseTag', { 'autoload' : { 'filetypes' : ['html'] }}
NeoBundleLazy 'hail2u/vim-css3-syntax', { 'autoload' : { 'filetypes' : ['html'] }}
NeoBundleLazy 'gorodinskiy/vim-coloresque', { 'autoload' : { 'filetypes' : ['html'] }}
NeoBundleLazy 'tpope/vim-haml', { 'autoload' : { 'filetypes' : ['html'] }}
NeoBundleLazy 'tmhedberg/matchit', { 'autoload' : { 'filetypes' : ['html'] }}

" Markdown
NeoBundleLazy 'plasticboy/vim-markdown', { 'autoload' : { 'filetypes' : ['markdown'] }}
NeoBundleLazy 'kannokanno/previm', { 'autoload' : { 'filetypes' : ['markdown'] }}
NeoBundleLazy 'tyru/open-browser.vim', { 'autoload' : { 'filetypes' : ['markdown'] }}

" Hatena Blog
NeoBundle 'mattn/webapi-vim'
NeoBundle 'moznion/hateblo.vim'

call neobundle#end()
NeoBundleCheck
" }}}

" SyntaxHighlight {{{
"====================
syntax enable
set background=dark
set t_Co=256
colorscheme hybrid
highlight Normal ctermbg=none
highlight LineNr ctermfg=darkgray

" }}}

" neocomplete.vim {{{
"====================
let g:neocomplete#enable_at_startup = 1
" _(underscore)区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
" Syntax Cache対象となる最小文字列長を3
let g:neocomplete#min_syntax_length = 3

" Define dictionary
let g:neocomplete#dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
    \ 'java' : $HOME.'/.vim/dict/java.dict',
    \ 'vim' : $HOME.'/.vim/dict/vim.dict'
    \ }

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Key mapping {{{
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplete#manual_omni_complete()
" }}}

" Enable omni completion
if !exists('g:neocomplete#omni_patterns')
    let g:neocomplete#omni_patterns = {}
endif
let g:neocomplete#omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" Enable force omni completion
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'


" Set include path
let g:neocomplete#include_paths = {
    \ 'cpp'  : '.,/usr/include,/usr/local/include',
    \ 'c'    : '.,/usr/include,/usr/local/include',
    \ 'ruby' : '.,/usr/lib/ruby/2.2.0/',
    \ }

" Set include pattern
let g:neocomplete#include_patterns = {
    \ 'c' : '^\s*#\s*include',
    \ 'cpp' : '^\s*#\s*include',
    \ 'ruby' : '^\s*require',
    \ }

" Set include dist file pattern
let g:neocomplete#include_exprs = {
    \ 'ruby' : substitute(v:fname,'::','/','g')
    \ }

" Set include file suffixes
let g:neocomplete#include_suffixes = {
  \ 'ruby' : '.rb',
  \ 'haskell' : '.hs'
  \ }

" }}}

" neosnippet {{{
"===============
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

let s:snippet_direction = '~/.vim/snippet/'
let g:neosnippet#snippets_directory = s:snippet_direction
" }}}

" Unite {{{
"==========
let g:unite_enable_start_insert=1
noremap <C-P> :Unite buffer<CR>
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-Z> :Unite file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" }}}

" vim-altr {{{
"==============
noremap <F3> <Plug>(altr-forward)
noremap <F2> <Plug>(altr-back)
" }}}

" indentLine {{{
"===============
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
" }}}

" vim-quickrun {{{
"=================
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60,
\       "outputter/buffer/split" : ":botright",
\       "outputter/buffer/close_on_empty" : 1
\   },
\   "cpp" : {
\       "cmdopt" : "-std=gnu++1y -W -Wall"
\   },
\}

"<C-c>の強制終了．quickrun未実行ならば，そのまま通す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" }}}

" vim-clang {{{
"===============
" disable auto completion for vim-clang
let g:clang_auto = 0

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'

let g:clang_exec = 'clang-svn'
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'
" }}}

