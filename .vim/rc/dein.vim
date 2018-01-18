let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo
endif
execute 'set runtimepath^=' .substitute(fnamemodify(s:dein_dir, ':p'), '/$', '', '')

let s:toml_dir  = '~/.vim/rc'
if !dein#load_state(s:dein_dir)
    finish
endif

call dein#begin(s:dein_dir, expand('<sfile>'))
call dein#load_toml(s:toml_dir . '/dein.toml',      {'lazy': 0})
call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
if has('nvim')
    call dein#load_toml(s:toml_dir . '/dein_neo.toml', {})
endif

if dein#tap('deoplete.nvim') && has('nvim')
    call dein#disable('neocomplete.vim')
endif

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
    call dein#install()
endif

