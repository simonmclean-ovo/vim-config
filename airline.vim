function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! GitStatus()
  return system("git status --porcelain " . shellescape(expand("%")))
endfunction

function! StatuslineGit()
  let l:result = ""
  let l:branchname = GitBranch()
  " Show branch name if applicable
  if (strlen(l:branchname) > 0)
    let l:result = l:branchname
    let l:fileStatus = trim(GitStatus())
    if (strlen(l:fileStatus) > 0)
      " Show status code if applicable
      let l:firstChar = strcharpart(l:fileStatus, 0, 1)
      if (l:firstChar != "f")
        let l:result = l:result . "[" . l:firstChar . "]"
      endif
    endif
  endif
  return l:result
endfunction

" Simplfiy the git info (just shows branchname)
let g:airline_section_b = '%{StatuslineGit()}'

" Remove file encoding section
let g:airline_section_y = ''

" Simplfy the line and column information
let g:airline_section_z = '%l/%L:%c'
