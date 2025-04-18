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
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                virtual_text = false,
                underline = false

            })

            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "ts_ls" },
                automatic_installation = true,
            }
        end
    },
}
