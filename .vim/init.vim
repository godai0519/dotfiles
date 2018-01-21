function! s:source_rc(file)
    let abspath = resolve(expand('~/.vim/rc/' . a:file))
    if filereadable(abspath)
        execute 'source' fnameescape(abspath)
    endif
endfunction

call s:source_rc('init.rc.vim')
call s:source_rc('dein.rc.vim')

"if !has('vim_starting')
    "call dein#call_hook('source')
    "call dein#call_hook('post_source')

    syntax enable
    filetype plugin indent on
"endif

call s:source_rc('options.rc.vim')
call s:source_rc('keyconfig.rc.vim')

if has('nvim')
    call s:source_rc('neovim.rc.vim')
endif

if IsWindows()
    call s:source_rc('windows.rc.vim')
endif

call s:source_rc('plugins/cursorline.vim')


set secure


" TeX {{{
let g:tex_conceal='' " texのconcealを無効化（#^ω^）
" }}}

"augroup fileTypeIndent
"    autocmd!
"    autocmd BufNewFile,BufRead vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
"augroup END
"

"let g:python_host_prog = '/full/path/to/neovim2/bin/python'
"let g:python3_host_prog = '/full/path/to/neovim3/bin/python'

" SyntaxHighlight
"====================
set background=dark
set t_Co=256
colorscheme hybrid
highlight Normal ctermbg=none
highlight LineNr ctermfg=darkgray

