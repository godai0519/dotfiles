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

if has('nvim')
    call s:source_rc('neovim.rc.vim')
endif

if IsWindows()
    call s:source_rc('windows.rc.vim')
endif

call s:source_rc('plugins/cursorline.vim')


set secure

"" Auto indent pasted text
"nnoremap p p=`]<C-o>
"nnoremap P P=`]<C-o>
"

"" Neosnippet {{{
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"let g:neosnippet#snippets_directory = '~/.vim/snippets/'
"" }}}
"
"" Denite {{{
"nnoremap [denite]  <Nop>
"nmap     <Space>u [denite]
"
"let g:denite_source_history_yank_enable=1
"nnoremap <silent> [denite]u :<C-u>Denite<Space>file<CR>
"nnoremap <silent> [denite]m :<C-u>Denite<Space>file_mru<CR>
"nnoremap <silent> [denite]f :<C-u>Denite<Space>buffer<CR>
"nnoremap <silent> [denite]g :<C-u>Denite<Space>grep<CR>
"nnoremap <silent> [denite]h :<C-u>Denite<Space>history/yank<CR>
"nnoremap <silent> [denite]b :<C-u>Denite<Space>bookmark<CR>
"nnoremap <silent> [denite]a :<C-u>DeniteBookmarkAdd<CR>
"
"" }}}
"
"" vim-altr {{{
"noremap <F3> <Plug>(altr-forward)
"noremap <F2> <Plug>(altr-back)
"" }}}
"
"" vim-parenmatch {{{
"let g:loaded_matchparen = 1 " vim標準のプラグインの無効化
"" }}}
"
"" indentLine {{{
"let g:indentLine_color_term = 111
"let g:indentLine_color_gui = '#708090'
"" }}}
"
"" TeX {{{
"let g:tex_conceal='' " texのconcealを無効化（#^ω^）
"" }}}
"
"" vim-clang-format.vim {{{
"let g:clang_format#code_style = 'LLVM'
"let g:clang_format#style_options = {
"    \ 'AccessModifierOffset': -4,
"    \ 'AllowShortBlocksOnASingleLine': 'true',
"    \ 'AllowShortIfStatementsOnASingleLine': 'true',
"    \ 'AlwaysBreakTemplateDeclarations': 'true',
"    \ 'BreakBeforeBraces': 'Stroustrup',
"    \ 'IndentWidth': 4,
"    \ }
"
"" map to <Leader>cf in C++ code
"augroup clang_format
"    autocmd!
"    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
"    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"augroup END
" " }}}
"
"nnoremap <silent> <Space>e :<C-u>tabedit $MYVIMRC<CR>
"nnoremap <silent> <Space>E :<C-u>source $MYVIMRC<CR>
"

"augroup fileTypeIndent
"    autocmd!
"    autocmd BufNewFile,BufRead vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
"augroup END
"
"" http://secret-garden.hatenablog.com/entry/2017/12/22/233144
"" タブの移動
"nnoremap <silent> <C-l> :tabnext<CR>
"nnoremap <silent> <C-h> :tabprevious<CR>
"nnoremap <silent> <C-Tab> :tabnext<CR>
"
"" タブページ自体を左右に移動させる
"command! -bar TabMoveNext :execute "tabmove " tabpagenr() % tabpagenr("$") + (tabpagenr("$") == tabpagenr() ? 0 : 1)
"command! -bar TabMovePrev :execute "tabmove" (tabpagenr() + tabpagenr("$") - 2) % tabpagenr("$") + (tabpagenr() == 1 ? 1 : 0)
"
"nnoremap <silent> <S-l> :TabMoveNext<CR>
"nnoremap <silent> <S-h> :TabMovePrev<CR>
"
"function GuiTabLabel()
"  let label = ''
"  let bufnrlist = tabpagebuflist(v:lnum)
"
"  " このタブページに変更のあるバッファがるときには '+' を追加する
"  for bufnr in bufnrlist
"    if getbufvar(bufnr, "&modified")
"      let label = '+'
"      break
"    endif
"  endfor
"
"  " ウィンドウが複数あるときにはその数を追加する
"  let wincount = tabpagewinnr(v:lnum, '$')
"  if wincount > 1
"    let label .= wincount
"  endif
"  if label != ''
"    let label .= ' '
"  endif
"
"  " バッファ名を追加する
"  return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
"endfunction
"
"set guitablabel=%{GuiTabLabel()}
"


" SyntaxHighlight
"====================
set background=dark
set t_Co=256
colorscheme hybrid
highlight Normal ctermbg=none
highlight LineNr ctermfg=darkgray

