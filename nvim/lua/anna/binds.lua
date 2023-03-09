vim.g.mapleader = " "

-- open in netrc
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- put and squash selection
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete into void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- yank to x11 clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])


-- move line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- jumping centres cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search centres cursor
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- disable capital Q (purgatory)
vim.keymap.set("n", "Q", "<nop>")

-- bind trouble.nvim
vim.keymap.set("n", "<leader>sd", "<cmd>TroubleToggle<cr>")
