" basic settings
set number
set ruler
set statusline+=%F
set backspace=indent,eol,start
set encoding=utf-8

syntax on
filetype plugin indent on

command! -nargs=* F Files <args>

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'git@github.com:github/copilot.vim.git'
Plug 'git@github.com:junegunn/fzf.git'
Plug 'git@github.com:junegunn/fzf.vim.git'

call plug#end()

let g:fzf_action = { 'enter': 'tab split' }
