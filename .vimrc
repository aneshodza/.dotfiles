" basic settings
set number
set ruler
set statusline+=%F
set backspace=indent,eol,start
set encoding=utf-8
set autoindent
set smartindent

" enable syntax highlighting
syntax enable
syntax on
filetype plugin indent on

" text search
set ignorecase
set smartcase
set incsearch
let g:ackprg = 'ag --vimgrep'

" statusline
set laststatus=2
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" nerdtree
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeShowHidden=1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusConcealBrackets = 1

" theme
packadd! onedark.vim
colorscheme onedark

" shortcuts
command! -nargs=* F Files <args>
command! -nargs=* FF Ag <args>
command! -nargs=* T NERDTree <args>
command! -nargs=* Q qa <args>

" vim-plugged
call plug#begin('~/.vim/plugged')

Plug 'git@github.com:preservim/nerdtree.git'
Plug 'git@github.com:Xuyuanp/nerdtree-git-plugin.git'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'git@github.com:github/copilot.vim.git'
Plug 'git@github.com:junegunn/fzf.git'
Plug 'git@github.com:junegunn/fzf.vim.git'
Plug 'git@github.com:sheerun/vim-polyglot.git'

call plug#end()
