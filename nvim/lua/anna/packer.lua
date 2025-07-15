local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.4' }
    use 'nvim-lua/plenary.nvim'
    use "ellisonleao/gruvbox.nvim"
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    use 'ntpeters/vim-better-whitespace'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'tpope/vim-surround'
    use 'folke/trouble.nvim'
    use 'tomtom/tcomment_vim'
    use 'mfussenegger/nvim-lint'
    use { "lukas-reineke/indent-blankline.nvim", main = 'ibl' }
    use "EdenEast/nightfox.nvim"
    use 'ryanoasis/vim-devicons'
    use 'andweeb/presence.nvim'
    use 'lambdalisue/suda.vim'
    use 'rmagatti/auto-session'
    use 'danilamihailov/beacon.nvim'
    use 'ThePrimeagen/harpoon'
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use "nvim-neotest/neotest"
    use "nvim-neotest/neotest-plenary"
    use "nvim-neotest/neotest-python"
    use "Issafalcon/neotest-dotnet"
    use "antoinemadec/FixCursorHold.nvim"
    use "nvim-neotest/nvim-nio"
    use "rcarriga/nvim-dap-ui"
    use "iabdelkareem/csharp.nvim"
    use "Tastyep/structlog.nvim"
    use 'Issafalcon/lsp-overloads.nvim'
    use "Wansmer/sibling-swap.nvim"
    use 'koenverburg/cmd-palette.nvim'
    use 'stevearc/dressing.nvim'
    use { 'EthanJWright/vs-tasks.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    }
    use 'f-person/git-blame.nvim'
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use 'Darazaki/indent-o-matic'
    use 'nicholasmata/nvim-dap-cs'
end)
