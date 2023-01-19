set number
set ruler
set statusline+=%F

set backspace=indent,eol,start

call pathogen#infect()
syntax on
filetype plugin indent on

command! -nargs=* Tree NERDTree <args>

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'git@github.com:github/copilot.vim.git'
Plug 'git@github.com:junegunn/fzf.vim.git'

call plug#end()
