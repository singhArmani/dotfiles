-- Set the localleader key (may be use it later)
vim.g.maplocalleader = ']'

-- Require the grug-far plugin
require('grug-far').setup();

-- Set the keybinding for the grug-far command
vim.api.nvim_set_keymap('n', '<leader>f', 
    ":lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } })<CR>", 
    { noremap = true, silent = true })

