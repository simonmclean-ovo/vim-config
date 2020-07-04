" Some basics
set encoding=UTF-8
set incsearch
set backspace=start,eol,indent
set ruler
set cursorline
set showcmd
set clipboard=unnamed
set modifiable
let mapleader = " "
set t_Co=256

" Syntax highlighting
syntax on
set synmaxcol=200

" formatting
filetype plugin indent on
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set nowrap

" Line numbers
highlight LineNr ctermfg=grey
set number

" Auto re-read file when it's changed, if there are no local changes
set autoread

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

" Overrides for diff view
if &diff
    syntax off
endif

" Toggle back and forth between two buffers
command! -nargs=0 PrevBuffer :b#

" Source vimrc
command! -nargs=0 Sauce :source ~/.vimrc

source ~/.vim/configs/truecolor.vim
source ~/.vim/configs/startify.vim
source ~/.vim/configs/coc.vim
source ~/.vim/configs/airline.vim
source ~/.vim/configs/NERDTree.vim
source ~/.vim/configs/fzf.vim
source ~/.vim/configs/indentline.vim
source ~/.vim/configs/camelcasemotion.vim
source ~/.vim/configs/whichkey.vim

" Plugins
call plug#begin('~/.vim/plugged')

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

" themes
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'kristijanhusak/vim-hybrid-material'

call plug#end()

" theme config should come after plugins to avoid issues
source ~/.vim/configs/themes/codedark.vim
" source ~/.vim/configs/themes/molokai.vim
" source ~/.vim/configs/themes/onedark.vim
" source ~/.vim/configs/themes/hybrid-material.vim

source ~/.vim/configs/italic-highlights.vim
