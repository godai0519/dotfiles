" Encoding {{{
"=============
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
scriptencoding utf-8
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
let s:cache_home = expand('~/.cache')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" deinがなければclone
if !isdirectory(s:dein_repo)
    execute system('git clone https://github.com/Shougo/dein.vim' . ' ' . shellescape(s:dein_repo))
endif
let &runtimepath = s:dein_repo . ',' . &runtimepath

" TOML {{{
" プラグインリストを収めた TOML ファイル
let s:toml_dir  = '~/.vim/rc'
let s:toml      = s:toml_dir . '/dein.toml'
let s:toml_lazy = s:toml_dir . '/dein_lazy.toml'

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml, s:toml_lazy])
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:toml_lazy, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif
" }}}

" 未インストールのプラグインをインストール
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

" プラグインロードできたので有効化
filetype plugin indent on
syntax enable
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
  return &ft =~# 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~# 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' !=# LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft ==# 'denite' ? denite#get_status_string() :
        \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
        \ '' !=# expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=# LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
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
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++'

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

" 'Shougo/deoplete.nvim' {{{
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#force_omni_input_patterns')
  let g:deoplete#force_omni_input_patterns = {} 
endif
let g:deoplete#force_overwrite_completefunc = 1
let g:deoplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:deoplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"}}}

" Neosnippet {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
" }}}


" Denite {{{
nnoremap [denite]  <Nop>
nmap     <Space>u [denite]

let g:denite_source_history_yank_enable=1
nnoremap <silent> [denite]u :<C-u>Denite<Space>file<CR>
nnoremap <silent> [denite]m :<C-u>Denite<Space>file_mru<CR>
nnoremap <silent> [denite]f :<C-u>Denite<Space>buffer<CR>
nnoremap <silent> [denite]g :<C-u>Denite<Space>grep<CR>
nnoremap <silent> [denite]h :<C-u>Denite<Space>history/yank<CR>
nnoremap <silent> [denite]b :<C-u>Denite<Space>bookmark<CR>
nnoremap <silent> [denite]a :<C-u>DeniteBookmarkAdd<CR>

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
let g:clang_format#code_style = 'LLVM'
let g:clang_format#style_options = {
    \ 'AccessModifierOffset': -4,
    \ 'AllowShortBlocksOnASingleLine': 'true',
    \ 'AllowShortIfStatementsOnASingleLine': 'true',
    \ 'AlwaysBreakTemplateDeclarations': 'true',
    \ 'BreakBeforeBraces': 'Stroustrup',
    \ 'IndentWidth': 4,
    \ }

" map to <Leader>cf in C++ code
augroup clang_format
    autocmd!
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
augroup END
 " }}}

nnoremap <silent> <Space>e :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Space>E :<C-u>source $MYVIMRC<CR>

highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
hi clear CursorLine


" 'cursorline' を必要な時にだけ有効にする
" http://d.hatena.ne.jp/thinca/20090530/1243615055
augroup vimrc_auto_cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

