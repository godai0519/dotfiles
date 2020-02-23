" ================== General Config ===================

set number                     "行番号表示
set ruler                      "現在地の表示
set showcmd
set visualbell
set autoread                   "書き換え時，自動で読みなおす
set backspace=indent,eol,start "BSで文字を消せるように
set nrformats=alpha,hex        "<C-a>と<C-x>での増減について，8進却下・英字許可
set hidden                     "保存しないで他のファイルを編集可能に
set clipboard+=unnamed         "OSのクリップボード使用
set foldmethod=marker          "markerで自動折りたたみ可能
set pumheight=10

" =============== Swap / Backup Config ================

set nobackup                   "上書き時バックアップ作成禁止
set noswapfile                 "swapファイル作成禁止
set nowb

" ===================== Scrolling =====================

set scrolloff=5         "カーソルの上下の最低行数
set sidescrolloff=16    "カーソルの左右の最低行数
set sidescroll=1        "画面の追従速度

" =================== Visualization ===================

set wrap                       "行折り返し
set breakindent                "行折り返しでインデントを考慮

" 強調設定
set showmatch                  "(),{}のお知らせ
set matchtime=1                "showmatchを0.1s
set cursorline                 "ライン強調

"バイナリファイルの非印字可能文字を16進数で表示
set display=uhex

" 不可視文字の設定
set list listchars=tab:»-,trail:_,extends:»,precedes:«,nbsp:%
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
augroup invisibleCharactorSetting
    autocmd!
    autocmd BufRead,BufNew * match JpSpace /　/
augroup END

" ==================== Status Line ====================

set laststatus=2               "ステータスラインの設定
set statusline=%f%m\ %{fugitive#statusline()}\ %=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}

" ================== Search Setting ===================

set ignorecase                "小文字検索で大文字ヒット
set smartcase                 "大文字を含む場合は厳密に
set incsearch                 "インクリメンタルサーチ
set nowrapscan                "
set whichwrap=b,s,h,l,<,>,[,] "
set history=1000              "コマンド、検索パターンを100個まで履歴に残す

" ========== Indentation / Tab Space Settings =========

set autoindent
set expandtab
set shiftwidth=4
set smartcase
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

