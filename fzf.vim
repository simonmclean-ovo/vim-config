let g:fzf_commits_log_options = '--all --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Exlude file names when using :Ag
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Search file contents with preview window
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

:map <C-f> :GGrep<CR>
:map <C-p> :GFiles<CR>
