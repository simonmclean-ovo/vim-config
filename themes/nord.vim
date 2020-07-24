" https://www.nordtheme.com/docs/colors-and-palettes

" These changes are mostly to match the VSCode Nord colours
augroup nord-theme-overrides
  autocmd!
  " 8 (Lightish blue-green)
  autocmd ColorScheme nord hi typescriptProp ctermfg=8 guifg=#88C0D0
  autocmd ColorScheme nord hi typescriptIdentifierName ctermfg=8 guifg=#88C0D0
  autocmd ColorScheme nord hi typescriptPredefinedType ctermfg=8 guifg=#88C0D0
  autocmd ColorScheme nord hi jsxAttrib ctermfg=8 guifg=#88C0D0
  " 9 (Darkish blue)
  autocmd ColorScheme nord hi typescriptNull ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptCastKeyword ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptClassKeyword ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptClassExtends ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptFuncKeyword ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptDefault ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptInterfaceKeyword ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptVariable ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptAliasKeyword ctermfg=9 guifg=#81A1C1
  autocmd ColorScheme nord hi typescriptExport ctermfg=9 guifg=#81A1C1
augroup END

let g:airline_theme = "nord"
colorscheme nord
