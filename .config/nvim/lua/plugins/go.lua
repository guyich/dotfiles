return {

'crispgm/nvim-go',
    config = function()
        require('go').setup({
            auto_lint = false,
        })
    end
}
