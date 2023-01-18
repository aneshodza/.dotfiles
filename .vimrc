set number
set ruler

call pathogen#infect()
syntax on
filetype plugin indent on

command! -nargs=* Tree NERDTree <args>
