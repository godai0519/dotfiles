inoremap <silent><expr> <TAB> pumbisible() ? "\<C-n>" :
"                                \ neosnippet#expandable_or_jumpable() ?
"                                \ \<Plug>(neosnippet_expand_or_jump) : \<TAB>
                                \ <SID>check_backspace() ? \<TAB> :
                                \ deoplete#manual_complete()
inoremap <expr><S-TAB>        pumbisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

snoremap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('clang', 'max_pattern_length', -1)

"if !exists('g:deoplete#force_omni_input_patterns')
"  let g:deoplete#force_omni_input_patterns = {} 
"endif
"let g:deoplete#force_overwrite_completefunc = 1
"let g:deoplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:deoplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

