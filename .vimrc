set number
set ruler

set backspace=indent,eol,start

call pathogen#infect()
syntax on
filetype plugin indent on

command! -nargs=* Tree NERDTree <args>
