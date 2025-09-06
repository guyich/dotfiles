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
            local lspconfig = require "lspconfig"

            vim.diagnostic.config({
                virtual_text = false,
                underline = false,
                signs = false

            })

            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "ts_ls" },
                automatic_installation = true,
            }
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('mason-lspconfig').setup_handlers {
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

