
-- keybinds
local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

-- quick convenience bind for mapping in normal mode with no recursion
local function nmap(key, f)
    map('n', key, f, opt)
end

local function vmap(key, f)
    map('v', key, f, opt)
end

vim.g.mapleader = " "

-- project navigation

nmap('<leader>sg', ":lua require('telescope.builtin').live_grep()<cr>")
nmap('<leader>sp', ":lua require('telescope.builtin').find_files()<cr>")
nmap('<leader>sb', ":lua require('telescope.builtin').buffers()<cr>")
nmap('<leader>t', ":NERDTreeToggle<CR>")
nmap('<leader>sf', ":lua require('telescope.builtin').current_buffer_fuzzy_find{}<cr>")

-- lsp binds

nmap('gd', ':lua vim.lsp.buf.definition()<cr>')
nmap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nmap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nmap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nmap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nmap('gr', ':lua vim.lsp.buf.references()<cr>')
nmap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nmap('K', ':lua vim.lsp.buf.hover()<cr>')
nmap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nmap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nmap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')
nmap('<leader>e', ':lua vim.diagnostic.open_float()<cr>')
nmap('[d', ':lua vim.diagnostic.goto_prev()<cr>')
nmap(']d', ':lua vim.diagnostic.goto_next()<cr>')
nmap('<leader>d', '<cmd>TroubleToggle<cr>')

-- other binds

map('v', 'J', ":m '>+1<CR>gv=gv", opt)
map('v', 'K', ":m '<-2<CR>gv=gv", opt)

map('t', '<Esc>', "<C-\\><C-n>", opt)

vmap("<leader>p", "\"_dP")
