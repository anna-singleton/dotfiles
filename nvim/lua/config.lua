-- tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.cursorline = false
vim.opt.cc = "80"
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.guicursor = ""

vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.cmd("set undodir=$HOME/.config/nvim/undodir") -- wont expand home otherwise
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.errorbells = false
vim.opt.completeopt = "menu,menuone,noselect,preview"
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.shell = "/bin/bash"

vim.g.airline_theme = "bubblegum"
vim.g.airline_powerline_fonts = true

vim.cmd("colorscheme gruvbox")
vim.cmd("highlight Normal guibg=none")

vim.g.vimtex_view_method = 'mupdf'
