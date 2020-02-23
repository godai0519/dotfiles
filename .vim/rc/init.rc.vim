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

