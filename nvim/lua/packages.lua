require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tomtom/tcomment_vim'
    use 'godlygeek/tabular'
    use 'gruvbox-community/gruvbox'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'scrooloose/nerdtree'
    use 'williamboman/nvim-lsp-installer'
    use 'tpope/vim-fugitive'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ray-x/lsp_signature.nvim'
    use 'windwp/nvim-autopairs'
    use 'ntpeters/vim-better-whitespace'
    use 'tpope/vim-surround'
    use 'etdev/vim-hexcolor'
end)

local configs = require 'nvim-treesitter.configs'
configs.setup{
   highlight = {
       enable = true,
   },
   indent = {
       enable = true,
   }
}

