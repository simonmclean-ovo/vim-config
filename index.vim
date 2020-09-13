" Some basics
set cursorline
set showcmd
set modifiable
set ignorecase
set smartcase
set number
set relativenumber
set clipboard=unnamed
set nowrap
let mapleader = " "

" Syntax highlighting
set synmaxcol=200

" Abbreviations
func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
iabbr clog console.log();<Left><Left><C-R>=Eatchar('\s')<CR>

" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Disable cursorline in quickfix
autocmd FileType qf set nocursorline

" Window control
nnoremap \| :vertical split<CR>
nnoremap - :split<CR>

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
command! -nargs=0 Source :source ~/.vimrc

" Open this file
command! -nargs=0 Config :e ~/.vim/configs/index.vim

" Function to show the highlight groups of whatever's under the cursor
command! -nargs=0 ShowHighlightGroups :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" TODO: this
function! <SID>DropLine()
endfunction

function <SID>GitLogLines(start, end)
  :execute "Git log -L " . a:start . "," . a:end . ":" . expand('%')
endfunction

command! -range Glines :call <SID>GitLogLines(<line1>, <line2>)

" Jumps
map [q :cprevious<CR>
map ]q :cnext<CR>

" Quickly enter command mode
nnoremap ; :
vnoremap ; :

" Delete next or previous empty line
" TODO: This is a bit dangerous in that it could make destructive changes that
" I don't notice. Maybe create a function that bounds the operation within a
" certain range of lines
nnoremap <C-k> {dd<c-o>
nnoremap <C-j> }dd<c-o>

" Add empty line above or below cursor
nnoremap <leader>k m`O<esc>``
nnoremap <leader>j m`o<esc>``

" Plugin configs
source ~/.vim/configs/airline.vim
source ~/.vim/configs/camelcasemotion.vim
source ~/.vim/configs/coc.vim
source ~/.vim/configs/emmet.vim
source ~/.vim/configs/floaterm.vim
source ~/.vim/configs/fzf.vim
source ~/.vim/configs/git-gutter.vim
source ~/.vim/configs/indentline.vim
source ~/.vim/configs/polyglot.vim
source ~/.vim/configs/whichkey.vim
source ~/.vim/configs/yoink.vim

" Misc config
source ~/.vim/configs/truecolor.vim

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bkad/camelcasemotion'
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
Plug 'svermeulen/vim-yoink'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/svg.vim'
Plug 'voldikss/vim-floaterm'
Plug 'yggdroot/indentline'

" themes
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'

call plug#end()

" theme configs
" TODO: Instead of commenting things out, use autocmd or similar to
" conditionally apply theme configs
" source ~/.vim/configs/themes/codedark.vim
" source ~/.vim/configs/themes/molokai.vim
" source ~/.vim/configs/themes/onedark.vim
" source ~/.vim/configs/themes/hybrid-material.vim
source ~/.vim/configs/themes/nord.vim

source ~/.vim/configs/italic-highlights.vim
