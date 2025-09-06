-- ### keybindings cheetsheet ###
-- yy - yank the line
-- yyp - yank and paste the line

local keymap = vim.keymap.set
local opts = opts

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

keymap('n', '<leader>/', ':noh<CR>',{noremap = true}) -- stops search highlighting
keymap('n', '<leader>w', ':w<CR>',{noremap = true}) -- save
keymap('n', '<leader>q', ':bd<CR>',{noremap = true}) -- quit
keymap('i', 'jk', '<ESC>', opts)
keymap({'v', 'c',}, '<leader>[', '<ESC>', opts)

keymap('n', '<leader><CR>', ':so %<CR>',{noremap = true}) -- source conf file
keymap('n', '<leader>ev', ':vsplit ~/.config/nvim/lua/settings/keymaps.lua<CR>',{noremap = true})
keymap('n', '<leader>tt', function() require("trouble").toggle("workspace_diagnostics") end)
--keymap('n', '<leader>b', ':Compile bash build.sh<CR>', {noremap = true})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Enable telescope fzf native, if installed
--local builtin = require('telescope.builtin')
--
---- See `:help telescope.builtin`
--vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
--
--vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
--vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
--vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
--vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
--vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- copy selection to system clipboard
keymap('n', '<leader>y', '"+y', opts)

-- normal mode navigation, no ctrl + w
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<leader>v', ':vsplit | lua vim.lsp.buf.definition()<CR>')

-- rotate windows
keymap('n', '<C-r>', '<C-w>R', opts)

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

-- make 
keymap('n', '<F5>', ':Compile make<CR>',{noremap = true})
