require("settings")

vim.g.gruvbox_material_background = "medium" -- hard, soft, medium
vim.g.gruvbox_material_palette = "original" -- original, mix, material
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_sign_column_background = 'none'
vim.cmd 'color gruvbox-material'

require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('neoscroll').setup()

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
    use({
        "Pocco81/true-zen.nvim",
        config = function()
             require("true-zen").setup {
                -- your config goes here
                -- or just leave it empty :)
             }
        end,
    })
    use 'ray-x/go.nvim'
    -- ui --
    use { 'nvim-lualine/lualine.nvim'}
    use { 'sainnhe/gruvbox-material' }
    use 'karb94/neoscroll.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
end)

