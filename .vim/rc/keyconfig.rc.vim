" ====================== vimrc ========================

nnoremap <silent> <Space>e :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Space>E :<C-u>source $MYVIMRC<CR>

" ====================== Tab ========================

" http://secret-garden.hatenablog.com/entry/2017/12/22/233144
" タブの移動
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprevious<CR>

" タブページ自体を左右に移動させる
command! -bar TabMoveNext :execute "tabmove " tabpagenr() % tabpagenr("$") + (tabpagenr("$") == tabpagenr() ? 0 : 1)
command! -bar TabMovePrev :execute "tabmove" (tabpagenr() + tabpagenr("$") - 2) % tabpagenr("$") + (tabpagenr() == 1 ? 1 : 0)

nnoremap <silent> <S-l> :TabMoveNext<CR>
nnoremap <silent> <S-h> :TabMovePrev<CR>

function GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " このタブページに変更のあるバッファがるときには '+' を追加する
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " ウィンドウが複数あるときにはその数を追加する
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= wincount
  endif
  if label != ''
    let label .= ' '
  endif

  " バッファ名を追加する
  return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
endfunction

set guitablabel=%{GuiTabLabel()}

" ================= Paste Auto Indent =================

nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

