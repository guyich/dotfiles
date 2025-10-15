return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                build = ":MasonUpdate",
            },
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local lspconfig = vim.lsp.config 

            vim.diagnostic.config({
                virtual_text = false,
                underline = false,
                signs = false

            })

            require("mason").setup()
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup()

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            mason_lspconfig.setup {
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
            }
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
          local cmp = require("cmp")
          
          vim.opt.completeopt = "menu,menuone,noselect"

          cmp.setup({
            mapping = {
              ["<C-n>"] = cmp.mapping.select_next_item(),
              ["<C-p>"] = cmp.mapping.select_prev_item(),
              ["<C-e>"] = cmp.mapping.abort(),           
              ["<CR>"] = cmp.mapping.confirm({ select = false }),
            },
            sources = {
              { name = "buffer" },
            },
          })
        end
    },
}

