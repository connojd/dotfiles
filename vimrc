
" vundle block ------------------------------------------------------------{{{
set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'wolf-dog/sceaduhelm.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'

call vundle#end()

filetype plugin indent on
let python_highlight_all=1
syntax on

" }}}

" config variables -----------------------------------------------------------{{{
set exrc
set secure
set updatetime=250
set ruler
set nohls
set relativenumber
set number
set cindent
set confirm
set title
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set makeprg=ninja
set completeopt+=preview
set switchbuf=usetab
set wildmenu
set wildmode=full
set wildchar=<Tab>

" set grep program
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" }}}

" colorscheme -----------------------------------------------------------{{{

if $TERM != "linux"
    colorscheme sceaduhelm
else
    colorscheme slate
endif

" }}}

" functions ---------------------------------------------------------------{{{
fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s///e
    %s///e
    %s///e
    call cursor(l, c)
endfun
" }}}

" augroups ----------------------------------------------------------------{{{
augroup format
    autocmd!
    autocmd BufWritePre * :call <SID>strip_trailing_whitespace()
    autocmd FileType c,cpp,h nnoremap <leader>cf :<c-u>ClangFormat<cr>
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" }}}

" plugin variables --------------------------------------------------------{{{

let g:lsp_async_completion = 1
if (executable('cquery'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/home/dev/.cache/cquery' },
        \ 'whitelist': ['c', 'cpp' ],
        \ })
endif

" }}}

" key mappings ------------------------------------------------------------{{{
let mapleader=","

""" edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>sb :sb

""" append semicolon
nnoremap <leader>as mqA;<esc>`q

""" make aw uppercase
inoremap <leader><c-u> <esc>vawUi
nnoremap <leader><c-u> vawU<esc>

""" buffer list
nnoremap <F5> :buffers<cr>:buffer<space>

set wildcharm=<c-z>
nnoremap <F6> :b <c-z>

""" ale maps
" nnoremap <leader>af :ALEFix<cr>
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
"
" """ tagbar key
" nnoremap <F8> :TagbarToggle<CR>

""" asyncomplete
inoremap <silent> <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent> <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <silent> <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

""" vim-lsp
nnoremap <leader>li :LspImplementation<cr>
nnoremap <leader>ln :LspRename<cr>
nnoremap <leader>ld :LspDefinition<cr>
nnoremap <leader>lr :LspReferences<cr>
nnoremap <leader>lcc :LspCqueryCallers<cr>
nnoremap <leader>lcd :LspCqueryDerived<cr>
nnoremap <leader>lcb :LspCqueryBase<cr>
nnoremap <leader>lcv :LspCqueryVars<cr>

" remap esc
inoremap <leader>e <esc>
vnoremap <leader>e <esc>

" remap quit/write
nnoremap <leader>d :q<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>sd :wq<cr>

" nops
inoremap <esc> <nop>
inoremap <esc>:w<cr> <nop>
inoremap <esc>:q<cr> <nop>
nnoremap :w<cr> <nop>
nnoremap :q<cr> <nop>

" remap window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" remap split-orientation toggle
nnoremap <leader>wv <c-w>H
nnoremap <leader>wf <c-w>K

" remap tab creation
" nnoremap <leader>t :tabedit<cr>

" remap make
nnoremap <leader>m :make<cr>

" remap vim-fugitive
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>

" remap vim-dispatch
nnoremap <leader>fh :Dispatch cmake --build ~/bareflank/build-hypervisor<cr>
nnoremap <leader>fhb :Dispatch! cmake --build ~/bareflank/build-hypervisor<cr>
nnoremap <leader>fht :Dispatch ninja -f ~/bareflank/build-hypervisor/build.ninja unittest<cr>

nnoremap <leader>fe :Dispatch cmake --build ~/bareflank/build-eapis<cr>
nnoremap <leader>feb :Dispatch! cmake --build ~/bareflank/build-eapis<cr>
nnoremap <leader>fet :Dispatch ninja -f ~/bareflank/build-eapis/build.ninja unittest<cr>

" }}}

" local sourcings ------------------------------------------------------------{{{
if filereadable(expand('~/bareflank/vimrc'))
    source ~/bareflank/vimrc
endif
" }}}
