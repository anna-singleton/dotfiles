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

-- disable q: (purgatory 2)
vim.keymap.set("n", "q:", "<nop>")

-- bind trouble.nvim
vim.keymap.set("n", "<leader>sd", "<cmd>TroubleToggle<cr>")

-- harpoon

vim.keymap.set("n", "<leader>h1", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set("n", "<leader>h2", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set("n", "<leader>h3", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set("n", "<leader>h4", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
vim.keymap.set("n", "<leader>h5", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>')

vim.keymap.set("n", "<leader>hm", '<cmd>lua require("harpoon.mark").add_file()<CR>')

vim.keymap.set("n", "<leader>h`", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
