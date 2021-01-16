augroup TrypticBindings
  autocmd!

  " Navigation
  autocmd FileType tryptic nnoremap <silent> <buffer> h :call tryptic#HandleMoveLeft()<cr>
  autocmd FileType tryptic nnoremap <silent> <buffer> l :call tryptic#HandleMoveRight()<cr>

  " Close Tryptic
  autocmd FileType tryptic nnoremap <silent> <buffer> q :tabclose<cr>

  " Toggle hidden files
  autocmd FileType tryptic nnoremap <silent> <buffer> <leader>. :call tryptic#ToggleHidden()<cr>

  " Add or remove from arglist
  autocmd FileType tryptic nnoremap <silent> <buffer> x :call tryptic#ToggleArglist()<cr>

  " Refresh view
  autocmd FileType tryptic nnoremap <silent> <buffer> R :call tryptic#Refresh()<cr>

augroup END
