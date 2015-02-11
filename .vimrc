"==========================================================
" Encoding
"==========================================================
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932


"==========================================================
" 基本設定
"==========================================================
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

nnoremap Y y$



"==========================================================
" 不可視文字の設定
"==========================================================
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<,nbsp:%   "各種特殊文字の文字
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue       "全角スペースの色
au BufRead,BufNew * match JpSpace /　/                          "全角スペース怖い
set display=uhex                                                "バイナリファイルの非印字可能文字を16進数で表示


"==========================================================
" 検索設定
"==========================================================
set ignorecase                "小文字検索で大文字ヒット
set smartcase                 "大文字を含む場合は厳密に
set incsearch                 "インクリメンタルサーチ
set nowrapscan                "
set whichwrap=b,s,h,l,<,>,[,] "
set history=1000              "コマンド、検索パターンを100個まで履歴に残す


"==========================================================
" インデント・タブスペース
"==========================================================
set autoindent
set expandtab
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set tabstop=4


"==========================================================
" Binary Editor
"==========================================================
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END



"==========================================================
" neobundle
"==========================================================
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

NeoBundle 'Shougo/neocomplete'
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

" Color
NeoBundle 'w0ng/vim-hybrid'

" C++
NeoBundleLazy 'Rip-Rip/clang_complete', { 'autoload' : { 'filetypes' : ['cpp'] }}
NeoBundleLazy 'vim-jp/cpp-vim',         { 'autoload' : { 'filetypes' : ['cpp'] }}

" Haskell
NeoBundleLazy 'eagletmt/ghcmod-vim',             { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'eagletmt/neco-ghc',               { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'kana/vim-filetype-haskell',       { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'dag/vim2hs',                      { 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'pbrisbin/vim-syntax-shakespeare', { 'autoload' : { 'filetypes' : ['haskell'] }}

" Lisp
NeoBundle 'vim-scripts/slimv.vim'

" HTML
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'tpope/vim-haml'

" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

filetype plugin indent on

NeoBundleCheck


"==========================================================
" SyntaxHighlight
"==========================================================
syntax enable
set background=dark
set t_Co=256
colorscheme hybrid
highlight Normal ctermbg=none
highlight LineNr ctermfg=darkgray


"==========================================================
" neocomplete
"==========================================================
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3 "デフォでいいか
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#force_overwrite_completefunc=1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()


"==========================================================
" neosnippet
"==========================================================
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

let s:snippet_direction = '~/.vim/snippet/'
let g:neosnippet#snippets_directory = s:snippet_direction


"==========================================================
" clang_complete
"==========================================================
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
let g:clang_complete_copen = 1
let g:clang_library_path = '/usr/lib'
let g:clang_user_options = '-std=gnu++1y -stdlib=libc++'


"==========================================================
" Unite
"==========================================================
let g:unite_enable_start_insert=1
noremap <C-P> :Unite buffer<CR>
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-Z> :Unite file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')


"==========================================================
" vim-altr
"==========================================================
noremap <F3> <Plug>(altr-forward)
noremap <F2> <Plug>(altr-back)


"==========================================================
" indentLine
"==========================================================
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'


"==========================================================
" vim-quickrun
"==========================================================
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


"==========================================================
" タブ/ウィンドウの設定
" http://qiita.com/wadako111/items/755e753677dd72d8036d
"==========================================================

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

