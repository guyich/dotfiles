return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'neovim/nvim-lspconfig'},
            {
                'williamboman/mason.nvim',
                build = ":MasonUpdate",
            },
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local lspconfig = require "lspconfig"

            vim.diagnostic.config({
                virtual_text = false,
                underline = false

            })

            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "tsserver" },
                automatic_installation = true,
            }
        end
    },
}
