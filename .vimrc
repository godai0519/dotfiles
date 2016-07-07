" Encoding {{{
"=============
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
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
set statusline=%f%m\ %{fugitive#statusline()}\ %=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
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

" Extension Settings {{{
"=======================
au BufRead,BufNewFile *.md set filetype=markdown
" }}}

" dein {{{
"===============
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" deinがなければclone
if !isdirectory(s:dein_repo)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo, ':p')

" TOML {{{
" プラグインリストを収めた TOML ファイル
let s:toml_dir  = '~/.vim/rc'
let s:toml      = s:toml_dir . '/dein.toml'
let s:toml_lazy = s:toml_dir . '/dein_lazy.toml'

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [s:toml, s:toml_lazy])
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:toml_lazy, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif
" }}}


" 未インストールのプラグインをインストール
if dein#check_install() && has('vim_starting')
    call dein#install()
endif

" プラグインロードできたので有効化
filetype plugin indent on
" }}}

" lightline {{{
"===============
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
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

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clang
let g:clang_auto = 0

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libstdc++'

" }}}

" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {} 
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" }}}

"" 'Shougo/deoplete.nvim' {{{
"let g:deoplete#enable_at_startup = 1
"
"if !exists('g:deoplete#force_omni_input_patterns')
"  let g:deoplete#force_omni_input_patterns = {} 
"endif
"let g:deoplete#force_overwrite_completefunc = 1
"let g:deoplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:deoplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
""}}}

" Unite {{{
let g:unite_enable_start_insert=1
noremap <C-P> :Unite buffer<CR>
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-Z> :Unite file_mru<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')

augroup UniteCommand
  autocmd!
  autocmd FileType unite call <SID>unite_settings()
augroup END

function! s:unite_settings() "{{{
  for source in unite#get_current_unite().sources
    let source_name = substitute(source.name, '[-/]', '_', 'g')
    if !empty(source_name) && has_key(s:unite_hooks, source_name)
      call s:unite_hooks[source_name]()
    endif
  endfor
endfunction"}}}

let s:unite_hooks = {}

" }}}

" vim-altr {{{
noremap <F3> <Plug>(altr-forward)
noremap <F2> <Plug>(altr-back)
" }}}

" vim-parenmatch {{{
let g:loaded_matchparen = 1 " vim標準のプラグインの無効化
" }}}

" indentLine {{{
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
" }}}

" TeX {{{
let g:tex_conceal='' " texのconcealを無効化（#^ω^）
" }}}

" vim-clang-format.vim {{{
let g:clang_format#code_style = "LLVM"
let g:clang_format#style_options = {
    \ "AccessModifierOffset": -4,
    \ "AllowShortBlocksOnASingleLine": "true",
    \ "AllowShortIfStatementsOnASingleLine": "true",
    \ "AlwaysBreakTemplateDeclarations": "true",
    \ "BreakBeforeBraces": "Stroustrup",
    \ "IndentWidth": 4,
    \ }

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" }}}

