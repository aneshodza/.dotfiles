" basic settings
set number
set ruler
set backspace=indent,eol,start
set encoding=utf-8
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set showmatch
set mouse=a

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

" coc
inoremap <silent><expr> <C-@> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
let g:coc_global_extensions = ['coc-html', 'coc-tsserver', 'coc-rust-analyzer', 'coc-css']

" nerdtree
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeShowHidden=1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
	\ 'Modified': '~',
	\ 'Staged': '+',
	\ 'Untracked': '?',
	\ 'Renamed': '>',
	\ 'Unmerged': '=',
	\ 'Deleted': '-',
	\ 'Dirty': '!',
	\ 'Clean': 'c',
	\ 'Ignored': 'I',
	\ 'Unknown': '¿'
	\ }

" theme
packadd! onedark.vim
colorscheme onedark

" fzf
let g:fzf_action = { 'enter': 'tab split' }

" Rg
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction


" shortcuts
command! -nargs=* F Files <args>
command! -nargs=* -bang FF call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* T NERDTree <args>
command! -nargs=* Q wqa <args>

" vim-plugged
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'git@github.com:preservim/nerdtree.git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'git@github.com:Xuyuanp/nerdtree-git-plugin.git'
Plug 'git@github.com:airblade/vim-gitgutter.git'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'git@github.com:github/copilot.vim.git'
Plug 'git@github.com:junegunn/fzf.git'
Plug 'git@github.com:junegunn/fzf.vim.git'
Plug 'git@github.com:sheerun/vim-polyglot.git'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'rust-lang/rust.vim'

call plug#end()
