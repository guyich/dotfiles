return{
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                }
            },
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '-u',
                '--hidden'
            },
        }
    end
}
