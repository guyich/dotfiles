-- [[ Setting options ]]base
-- See `:help vim.o`

--vim.o.list = true
--vim.o.listchars = "trail:~,space:·,tab:··,nbsp:␣" -- eol:¤,
vim.o.background = dark
vim.o.backup = false -- disable backup file
vim.o.clipboard = "unnamedplus" -- system clipboard
--vim.o.textwidth = 80
vim.o.scrolloff = 50
vim.o.sidescrolloff = 10

vim.o.number = true
vim.o.rnu = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.lazyredraw = true
vim.o.encoding = 'UTF-8'
vim.o.cursorline = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.undofile = true
vim.o.showcmd = false
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 1000
vim.o.splitright = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
