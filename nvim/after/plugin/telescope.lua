local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sp', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
