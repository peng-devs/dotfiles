-- vim.keymap.set('n', '<leader>x', ':Bdelete<cr>', { silent = true })
vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>fd', ':TroubleToggle<cr>', { silent = true })
vim.keymap.set('n', '<leader>o', ':NvimTreeFindFileToggle<CR>', { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fc', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>l', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>h', '<c-o>')
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>N', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
