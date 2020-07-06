" Some basics
set cursorline
set showcmd
set clipboard=unnamed
set modifiable
let mapleader = " "

" Disable cursorline in quickfix
autocmd FileType qf set nocursorline

" Syntax highlighting
set synmaxcol=200

" formatting
set expandtab
set nowrap

" Line numbers
highlight LineNr ctermfg=grey
set number

" Use the old regex engine (performance fix)
autocmd FileType css scss less sass regexpengine=1

let g:polyglot_disabled = ['vue']
let g:vue_pre_processors='detect_on_enter'

" Window control
:map \| :vertical split<CR>
:map - :split<CR>

" Move junk files 
if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p", 0700)
endif
set directory=~/.vim/swap//

if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
endif
set undodir=~/.vim/undo//

" Toggle back and forth between two buffers
command! -nargs=0 PrevBuffer :b#

" Source vimrc
command! -nargs=0 Sauce :source ~/.vimrc

" Open this file
command! -nargs=0 Config :e ~/.vim/configs/index.vim

" TODO: Handle self closing tags
" - Changing tag name, and
" - Changing tag to self closing like 'tagname/'
function! <SID>ChangeElementName()
  call inputsave()
  let l:rawInput = input('Change element to: ')
  call inputrestore()
  let l:trimmedInput = trim(rawInput)
  " mark, vis select tag, move to start of vis select
  :execute "normal! mmvat\<esc>`<"
  " search to next space or >
  :execute "normal! / \\|>\<cr>"
  " change back to <
  :execute "normal! cT<" . trimmedInput
  " jump to end of vis select, write closing tag
  :execute "normal! `>ci</" . trimmedInput
  " return to mark
  :execute "normal! `m"
endfunction

function! <SID>DeleteElement()
  :execute "normal! vato\<esc>"
  let l:openLine = line(".")
  :execute "normal! vat\<esc>"
  let l:closeLine = line(".")
  if (openLine == closeLine) 
    :execute "normal! ditvatp"
  else
    :execute "normal! `<dd`>dd"
    " TODO: Maybe format the block that was between the tags?
  endif
endfunction

" TODO: Doesn't work for <div>thingtoexpand</div>
function! <SID>ExpandElement()
  execute ":normal! diWi<\<esc>pa></\<esc>pa>\<esc>?>\<cr>"
endfunction

" TODO: Cursor pos stuff at the end doesn't work
function! <SID>InsertElement()
  call inputsave()
  let l:rawInput = input('Insert element: ')
  call inputrestore()
  let l:trimmedInput = trim(l:rawInput)
  let l:lastChar = strpart(trimmedInput, strlen(trimmedInput) - 1)
  :execute "normal! i<".trimmedInput
  if (l:lastChar == '/')
    :execute "normal! xa />"
    :normal! 3h
  else
    :execute "normal! a></".l:trimmedInput.">"
    :normal! ?>n
  endif
endfunction

" TODO: this
function! <SID>DropLine()
endfunction

nnoremap <leader>ce :call <SID>ChangeElementName()<CR>
nnoremap <leader>de :call <SID>DeleteElement()<CR>
nnoremap <leader>ee :call <SID>ExpandElement()<CR>
nnoremap <leader>ie :call <SID>InsertElement()<CR>
nnoremap <leader>o :call <SID>DropLine()<CR>

" Plugin configs
source ~/.vim/configs/startify.vim
source ~/.vim/configs/coc.vim
source ~/.vim/configs/airline.vim
source ~/.vim/configs/NERDTree.vim
source ~/.vim/configs/fzf.vim
source ~/.vim/configs/indentline.vim
source ~/.vim/configs/camelcasemotion.vim
source ~/.vim/configs/whichkey.vim

" Misc config
source ~/.vim/configs/truecolor.vim

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'posva/vim-vue'
Plug 'vim-scripts/svg.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'yggdroot/indentline'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'bkad/camelcasemotion'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'mhinz/vim-startify'
Plug 'francoiscabrol/ranger.vim'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-sleuth'

" themes
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'kristijanhusak/vim-hybrid-material'

call plug#end()

" theme configs
source ~/.vim/configs/themes/codedark.vim
" source ~/.vim/configs/themes/molokai.vim
" source ~/.vim/configs/themes/onedark.vim
" source ~/.vim/configs/themes/hybrid-material.vim

source ~/.vim/configs/italic-highlights.vim
