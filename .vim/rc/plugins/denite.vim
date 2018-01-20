" ====================== Denite =======================
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

