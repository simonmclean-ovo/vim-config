" Sets certain highlight groups to italic
" Designed to work with fancy fonts like Dank Mono

" Function to show the highlight groups of whatever's under the cursor
command! -nargs=0 ShowHighlightGroups :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Typescript
highlight typescriptFuncKeyword cterm=italic
highlight typescriptVariable cterm=italic
highlight typescriptExport cterm=italic
highlight typescriptInterfaceKeyword cterm=italic
highlight typescriptAliasKeyword cterm=italic
highlight typescriptClassKeyword cterm=italic
highlight typescriptClassExtends cterm=italic
highlight typescriptIdentifier cterm=italic
highlight typescriptDefault cterm=italic
highlight typescriptNull cterm=italic
highlight typescriptAccessibilityModifier cterm=italic
highlight typescriptBoolean cterm=italic

" JavaScript
highlight jsFunction cterm=italic
highlight jsStorageClass cterm=italic
highlight jsNull cterm=italic
highlight jsUndefined cterm=italic
highlight jsBooleanTrue cterm=italic
highlight jsBooleanFalse cterm=italic
highlight jsClassKeyword cterm=italic
highlight jsExport cterm=italic

" JSX
highlight jsxAttrib cterm=italic
