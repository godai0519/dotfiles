function! IsWindows() abort
    return has('win32') || has('win64')
endfunction

function! IsUnix() abort
    return !IsWindows()
endfunction

" ===================== Encoding ======================

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
scriptencoding utf-8
language message C

" =================== General Config ==================

if IsWindows()
    set shellslash
endif

" ======================= Dein ========================

let s:cache_dir = expand('~/.cache')
if !isdirectory(s:cache_dir)
    call mkdir(s:cache_dir, 'p')
endif

let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
    if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
        let s:dein_dir = expand(s:cache_dir . '/dein') . '/repos/github.com/Shougo/dein.vim'
        if !isdirectory(s:dein_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        endif
    endif
    execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p'), '/$', '', '')
endif

