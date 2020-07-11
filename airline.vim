function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? l:branchname : ''
endfunction

" Simplfiy the git info (just shows branchname)
let g:airline_section_b = '%{StatuslineGit()}'

" Remove file encoding section
let g:airline_section_y = ''

" Simplfy the line and column information
let g:airline_section_z = '%l/%L:%c'
