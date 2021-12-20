"AUTO INSTALLATION OF vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(has('nvim') ? stdpath('data') . 'plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'nanotech/jellybeans.vim'
Plug 'godlygeek/tabular'
Plug 'fladson/vim-kitty'

"
" List ends here. Plugins become visible to nvim after this call
call plug#end()

"COLOURSCHEME CONFIG, FOUND AT: https://vimawesome.com/plugin/onedark-vim

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
colorscheme jellybeans

"CONFIGS HERE

set showmatch
set tabstop=4
set softtabstop=4
set sw=4
set autoindent
set number
set cc=80
set completeopt-=preview
set cursorline
set scrolloff=10
set foldenable
set foldmethod=syntax

"REMAPPINGS HERE

tnoremap <Esc> <C-\><C-n>
let mapleader = ","
nnoremap <C-t> :NERDTreeToggle<CR>

