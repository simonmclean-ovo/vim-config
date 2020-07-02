let g:fzf_commits_log_options = '--all --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
:map <C-p> :FZF<CR>
