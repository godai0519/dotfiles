if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd BufRead,BufNewFile *.md setf markdown
augroup END

