" Some basics
set cursorline
set showcmd
set clipboard=unnamed
set modifiable
set ignorecase
set smartcase
let mapleader = " "

" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Disable cursorline in quickfix
autocmd FileType qf set nocursorline

" Syntax highlighting
set synmaxcol=200

" formatting
set expandtab
set nowrap

" Line numbers
set number

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

" TODO: this
function! <SID>DropLine()
endfunction

nnoremap <leader>ce :call <SID>ChangeElementName()<CR>
nnoremap <leader>de :call <SID>DeleteElement()<CR>
nnoremap <leader>ee :call <SID>ExpandElement()<CR>
nnoremap <leader>ie :call <SID>InsertElement()<CR>
nnoremap <leader>o :call <SID>DropLine()<CR>

" Scroll up and down without moving the cursor
map <C-k> <C-Y>
map <C-j> <C-E>

" Plugin configs
source ~/.vim/configs/airline.vim
source ~/.vim/configs/camelcasemotion.vim
source ~/.vim/configs/coc.vim
source ~/.vim/configs/emmet.vim
source ~/.vim/configs/fzf.vim
source ~/.vim/configs/git-gutter.vim
source ~/.vim/configs/indentline.vim
source ~/.vim/configs/polyglot.vim
source ~/.vim/configs/whichkey.vim

" Misc config
source ~/.vim/configs/truecolor.vim

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bkad/camelcasemotion'
Plug 'francoiscabrol/ranger.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/svg.vim'
Plug 'yggdroot/indentline'

" themes
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'

call plug#end()

" theme configs
source ~/.vim/configs/themes/codedark.vim
" source ~/.vim/configs/themes/molokai.vim
" source ~/.vim/configs/themes/onedark.vim
" source ~/.vim/configs/themes/hybrid-material.vim

source ~/.vim/configs/italic-highlights.vim
