return{
    "blazkowolf/gruber-darker.nvim"
}

--return {
--    'luisiacc/handmade-hero-theme',
--    config = function()
--        vim.cmd([[colorscheme handmade-hero-theme]])
--    end


--return {
--    'blazkowolf/gruber-darker.nvim',
--    opts = {
--        italic = {
--            strings = false,
--            comments = false,
--            operators = false,
--            folds = false,
--        },
--    },
--}

--return {
--    'sainnhe/gruvbox-material',
--    lazy = false, -- make sure we load this during startup if it is your main colorscheme
--    priority = 1000, -- make sure to load this before all the other start plugins
--    config = function()
--        vim.cmd([[
--            set background=dark
--            let g:gruvbox_material_better_performance = 1
--            let g:gruvbox_material_foreground = 'material'
--            let g:gruvbox_material_disable_italic_comment = 1
--            let g:gruvbox_material_enable_bold = 1
--
--            let g:gruvbox_material_diagnostic_text_highlight = 1
--            " let g:gruvbox_material_diagnostic_line_highlight = 1
--            let g:gruvbox_material_diagnostic_virtual_text = "colored"
--            let g:gruvbox_material_sign_column_background = 'none'
--
--            colorscheme gruvbox-material
--            ]])
--    end,
--}

--return {
--    'ellisonleao/gruvbox.nvim',
--    priority = 1000,
--    config = function ()
--        vim.o.background = 'dark'
--        require('gruvbox').setup({
--            bold = true,
--            italic = {
--                strings = false,
--                emphasis = false,
--                comments = false,
--                operators = false,
--                folds = false,
--            },
--            contrast = 'dark',
--        })
--        vim.cmd([[colorscheme gruvbox]])
--    end
--}

