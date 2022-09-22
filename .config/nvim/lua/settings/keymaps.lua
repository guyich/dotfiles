-- ### keybindings cheetsheet ###
-- yy - yank the line
-- yyp - yank and paste the line

local keymap = vim.keymap.set
local opts = opts

vim.g.mapleader = ' '

keymap('n', '<leader>/', ':noh<CR>',{noremap = true}) -- stops search highlighting
keymap('n', '<leader>w', ':w<CR>',{noremap = true}) -- save
keymap('n', '<leader>q', ':q<CR>',{noremap = true}) -- quit
keymap('i', 'jk', '<ESC>', opts)

keymap('n', '<leader><CR>', ':so %<CR>',{noremap = true}) -- source conf file
keymap('n', '<leader>ev', ':vsplit ~/.config/nvim/lua/settings/keymaps.lua<CR>',{noremap = true})
keymap('n', '<leader>b', ':Telescope buffers<CR>', {noremap = true})
keymap('n', '<leader>gr', ':Telescope live_grep<CR>', {noremap = true})
keymap('n', '<leader>pf', ':Telescope find_files<CR>', {noremap = true})
keymap('n', '<leader>th', ':Telescope help_tags<CR>', {noremap = true})

-- copy selection to system clipboard
keymap('n', '<leader>y', '"+y', opts)

-- normal mode navigation, no ctrl + w
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- move line up/down
keymap('n', '<leader>j', 'ddp', opts)
keymap('n', '<leader>k', 'ddkP', opts)

-- buffers
keymap('n', '<leader>l', ':bnext<CR>', opts)
keymap('n', '<leader>h', ':bprevious<CR>', opts)

-- quickfix list
keymap('n', '<leader>o', ':copen<CR>', opts)
keymap('n', '<leader>cc', ':ccl<CR>', opts)

-- indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
