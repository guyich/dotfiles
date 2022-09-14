local set = vim.opt

set.scrolloff = 5
set.number = true
set.rnu = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.expandtab = true
set.swapfile = false
set.termguicolors = true
set.lazyredraw = true
set.encoding = 'UTF-8'
set.cursorline = true

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>/', ':noh<CR>',{noremap = true})
vim.keymap.set('n', '<leader>w', ':w<CR>',{noremap = true})
vim.keymap.set('n', '<leader>q', ':q!<CR>',{noremap = true})
vim.keymap.set('n', '<leader><CR>', ':so %<CR>',{noremap = true})
vim.keymap.set('n', '<leader>ev', ':vsplit $MYVIMRC<CR>',{noremap = true})
vim.keymap.set('n', '<leader>sv', ':w<CR>:so %<CR>:q<CR>',{noremap = true})
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', {noremap = true})
vim.keymap.set('n', '<leader>gr', ':Telescope live_grep<CR>', {noremap = true})
vim.keymap.set('n', '<leader>pf', ':Telescope find_files<CR>', {noremap = true})
vim.keymap.set('n', '<leader>th', ':Telescope help_tags<CR>', {noremap = true})

vim.g.gruvbox_material_background = "medium" -- hard, soft, medium
vim.g.gruvbox_material_palette = "original" -- original, mix, material
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_sign_column_background = 'none'
vim.cmd 'color gruvbox-material'

require('lualine').setup ({
    options = {theme = 'gruvbox-material'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'encoding', 'fileformat', 'filetype','filename','location'},
        lualine_x = {'buffers'},
    },
    inactive_sections = {
        lualine_y = {},
        lualine_z = {}
    },
})


require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})


local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Diagnostics symbols for display in the sign column.
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

require'lspconfig'.gopls.setup{}

vim.keymap.set('n', '<space>,', ':lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>;', ':lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>a', ':lua vim.lsp.diagnostic.code_action()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>d', ':lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>f', ':lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>h', ':lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>m', ':lua vim.lsp.buf.rename()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>r', ':lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<space>s', ':lua vim.lsp.buf.document_symbol()<CR>', {noremap = true, silent = true})

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    -- lsp --
    use { "williamboman/mason.nvim" }
    use { 'neovim/nvim-lspconfig' }
    use { 'onsails/lspkind-nvim' }
    -- stuff --
    use { 'nvim-treesitter/nvim-treesitter'}
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'ray-x/go.nvim'
    -- ui --
    use { 'nvim-lualine/lualine.nvim'}
    use 'kyazdani42/nvim-web-devicons'
    use { 'sainnhe/gruvbox-material' }
end)

