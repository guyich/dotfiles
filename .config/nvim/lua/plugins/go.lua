--return{
--    "ray-x/go.nvim",
--    dependencies = {  -- optional packages
--        "ray-x/guihua.lua",
--    },
--    config = function()
--        require("go").setup()
--        require("go.format").goimport()  -- goimport + gofmt
--    end,
--    event = {"CmdlineEnter"},
--    ft = {"go", 'gomod'},
--    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
--}



return{

'crispgm/nvim-go',
    config = function()
        require('go').setup({
            auto_lint = false,
        })
    end
}
