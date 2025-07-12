vim.opt.guicursor = ""
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
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.cmd("set undodir=$HOME/.config/nvim/undodir") -- wont expand home otherwise
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.errorbells = false
vim.opt.scrolloff = 5
vim.opt.updatetime = 50

vim.opt.termguicolors = true

vim.g.better_whitespace_enabled = true
vim.g.strip_whitespace_on_save = false
vim.g.strip_whitespace_confirm = false

vim.g.suda_smart_edit = true

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
vim.cmd [[set nofoldenable]]
