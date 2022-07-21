"AUTO INSTALLATION OF vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(has('nvim') ? stdpath('data') . 'plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'fladson/vim-kitty'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"
" List ends here. Plugins become visible to nvim after this call
call plug#end()

syntax on

" tab settings
set tabstop=4
set softtabstop=4
set sw=4
set expandtab

" relative line numbers
set relativenumber
set nu

" 'electric' stuff
set autoindent
set smartindent
set showmatch

" character limit / hl
set cc=80
set cursorline

" folding
set foldenable
set foldmethod=syntax

" disable backup stuff
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile

" searching
set nohlsearch
set incsearch

" other
set hidden
set noerrorbells
set completeopt=menuone,noinsert,noselect
set scrolloff=10
set nowrap
set signcolumn=yes
set termguicolors

" gui
colorscheme gruvbox
highlight Normal guibg=none

" relative number setup
:set number relativenumber
:set nu rnu
:set number

tnoremap <Esc> <C-\><C-n>
let mapleader = " "
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<cr>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" autocommands

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

:augroup anna
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
:augroup END
