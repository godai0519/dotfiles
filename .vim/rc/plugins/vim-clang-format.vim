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
augroup clangFormat
    autocmd!
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
augroup END

