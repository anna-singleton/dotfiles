-- keybinds
local map = vim.api.nvim_set_keymap
local opt = { noremap = true }

vim.g.mapleader = " "

map('n', '<leader>ps', ":lua require('telescope.builtin').live_grep()<cr>", opt)
map('n', '<leader>fs', ":lua require('telescope.builtin').find_files()<cr>", opt)

map('n', '<leader>t', ":NERDTreeToggle<CR>", opt)

map('v', 'J', ":m '>+1<CR>gv=gv", opt)
map('v', 'K', ":m '<-2<CR>gv=gv", opt)

map('t', '<Esc>', "<C-\\><C-n>", opt)


-- lsp binds

-- quick convenience bind for mapping in normal mode with no recursion
local function nmap(key, f)
    map('n', key, f, opt)
end

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

