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

" Exclude block navigation from the jumplist
nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>

" Quickly enter command mode
nnoremap ; :
vnoremap ; :

" Quickly toggle between buffers
nnoremap <leader><leader> <c-^>

" Delete next or previous empty line
" TODO: This is a bit dangerous in that it could make destructive changes that
" I don't notice. Maybe create a function that bounds the operation within a
" certain range of lines
nnoremap <C-k> {dd<c-o>
nnoremap <C-j> }dd<c-o>

" Add empty line above or below cursor
nnoremap <leader>k :call append(line('.')-1, '')<CR>
nnoremap <leader>j :call append(line('.'), '')<CR>

nnoremap <silent> <leader>p :set operatorfunc=ReplaceMotion<CR>g@
function! ReplaceMotion(type)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:type == 'line'
    execute "normal! '[V']"
    silent normal "_dp
  elseif a:type == 'char'
    execute "normal! `[v`]"
    silent normal "_d
    execute "normal! \<s-p>"
  endif

  let &selection = sel_save
endfunction

let g:millerActiveDir = ''
let g:millerParentDir = ''
let g:millerPreviewPath = ''

function! ListFiles(fileList)
  execute "normal! ggdG"

  for file in a:fileList
    let name = file
    if (isdirectory(file))
      let name = name . '/'
    endif
    put =name
  endfor
  execute "normal! ggdd"

  call ConfigBuffer(1)
endfunction

function! Miller(path)
  let concealPattern = "^\/.*\/.\@="

  " prevent buffers from being added to buffer list
  set nobuflisted

  let g:millerActiveDir = a:path

  tabnew
  vnew
  vnew

  call GoWindowRight()
  call UpdateActiveDir()
  call UpdateParentDir()
  call SetPreviewWindow(GetPathUnderCursor())
endfunction

function! GetDirContents(path)
  return globpath(a:path, '*', 0, 1)
endfunction

function! GetParentPath(currentPath)
  let pathParts = split(a:currentPath, '/')
  if (len(pathParts))
    call remove(pathParts, len(pathParts) - 1)
    let parentPath = '/' . join(pathParts, '/')
    return parentPath
  else
    return 0
  endif
endfunction

function! GetPathUnderCursor()
  normal 0"ay$
  return @a
endfunction

function! GoWindowLeft()
  execute "normal! \<C-w>h"
endfunction

function! GoWindowRight()
  execute "normal! \<C-w>l"
endfunction

function! HandleMoveLeft()
  if (g:millerParentDir != "/")
    let g:millerActiveDir = GetParentPath(g:millerActiveDir)
    call UpdateActiveDir()
    call UpdateParentDir()
    call SetPreviewWindow(GetPathUnderCursor())
  endif
endfunction

function! HandleMoveDown()
  execute "normal! j"
  let l:pathUnderCursor = GetPathUnderCursor()
  call SetPreviewWindow(l:pathUnderCursor)
endfunction

function! HandleMoveUp()
  execute "normal! k"
  let l:pathUnderCursor = GetPathUnderCursor()
  call SetPreviewWindow(l:pathUnderCursor)
endfunction

function! HandleMoveRight()
  let pathUnderCursor = GetPathUnderCursor()
  if (isdirectory(pathUnderCursor))
    let g:millerActiveDir = pathUnderCursor
    call UpdateActiveDir()
    call UpdateParentDir()
    call SetPreviewWindow(GetPathUnderCursor())
  else
    echo "OPEN!"
  endif
endfunction

" Assumes that g:millerActiveDir has been updated, and is the focused window
function! UpdateActiveDir()
  call EnableBufferEdit()
  call ListFiles(GetDirContents(g:millerActiveDir))
  call ConfigBuffer(1)
endfunction

" Assumes that g:millerActiveDir has been updated, and is the focused window
function! UpdateParentDir()
  let g:millerParentDir = GetParentPath(g:millerActiveDir)
  call GoWindowLeft()
  call EnableBufferEdit()
  let dirContents = GetDirContents(g:millerParentDir)
  if (g:millerParentDir != "/")
    call ListFiles(GetDirContents(g:millerParentDir))
  else
    execute 'normal! ggdG'
    call setline('.', "/")
  endif
  call ConfigBuffer(1)
  call GoWindowRight()
endfunction

" Assumes that g:millerActiveDir has been updated, and is the focused window
function! SetPreviewWindow(path)
  call GoWindowRight()
  call EnableBufferEdit()
  if (isdirectory(a:path))
    let dirContents = GetDirContents(a:path)
    if (len(dirContents) > 0)
      call ListFiles(dirContents)
    else
      execute 'normal! ggdG'
      call setline('.', "empty directory")
    endif
  else
    execute 'normal! ggdG'
    execute 'read' a:path
    execute 'normal! ggdd'
  endif
  call ConfigBuffer(0)
  setlocal syntax=off
  call GoWindowLeft()
endfunction

function! ConfigBuffer(isDir)
  setlocal readonly
  setlocal nomodifiable
  setlocal nobuflisted
  setlocal buftype=nowrite
  setlocal bufhidden=delete
  setlocal noswapfile

  if (a:isDir)
    setlocal filetype=miller
  endif
endfunction

function! EnableBufferEdit()
  setlocal noreadonly
  setlocal modifiable
endfunction

augroup miller
  autocmd!
  autocmd FileType miller nnoremap <silent> <buffer> h :call HandleMoveLeft()<cr>
  autocmd FileType miller nnoremap <silent> <buffer> j :call HandleMoveDown()<cr>
  autocmd FileType miller nnoremap <silent> <buffer> k :call HandleMoveUp()<cr>
  autocmd FileType miller nnoremap <silent> <buffer> l :call HandleMoveRight()<cr>
augroup END

command! Miller :call Miller(expand('%:p:h'))<CR>

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
source ~/.vim/configs/wiki.vim
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
Plug 'justinmk/vim-dirvish'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'mustache/vim-mustache-handlebars'
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
Plug 'vimwiki/vimwiki'
Plug 'voldikss/vim-floaterm'
Plug 'yggdroot/indentline'

" themes
Plug 'arcticicestudio/nord-vim'
Plug 'fcpg/vim-farout'
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

call plug#end()

" theme configs
" TODO: Instead of commenting things out, use autocmd or similar to
" conditionally apply theme configs
" source ~/.vim/configs/themes/codedark.vim
" source ~/.vim/configs/themes/molokai.vim
" source ~/.vim/configs/themes/onedark.vim
" source ~/.vim/configs/themes/hybrid-material.vim
" source ~/.vim/configs/themes/nord.vim

colorscheme farout
source ~/.vim/configs/italic-highlights.vim
