
set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

call vundle#end()
filetype plugin indent on
syntax on

set updatetime=250
set ruler
set nohls
set relativenumber
set number
set autoindent
set confirm
set title
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

if $TERM != "linux"
    colorscheme lettuce
else
    colorscheme slate
endif

fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>strip_trailing_whitespace()

let g:lsp_async_completion=1
if (executable('clangd'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'h']
        \ })
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

let mapleader=","

inoremap <leader>r <Esc>
vnoremap <leader>r <Esc>

" remap window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" remap splits
nnoremap <leader>wv <C-w>H
nnoremap <leader>wf <C-w>K

" remap tab creation
nnoremap <leader>te :tabedit

" remap quit
nnoremap <leader>e :q<CR>

" remap write
nnoremap <leader>s :w<CR>

" remap write then quit
nnoremap <leader>se :wq<CR>

" remap fugitive
nnoremap <leader>gw :Gwrite
nnoremap <leader>gr :Gread
nnoremap <leader>gm :Gmove
nnoremap <leader>gc :Gcommit
nnoremap <leader>gs :Gstatus
nnoremap <leader>gd :Gdiff

 " remap ack
 nnoremap <leader>a :Ack
