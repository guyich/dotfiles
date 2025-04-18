-- mycolorscheme.lua
local M = {}

-- Color palette
local colors = {
    bg = "#282c34",
    fg = "#abb2bf",
    gray = "#5c6370",
    blue = "#61afef",
    green = "#98c379",
    purple = "#c678dd",
    red = "#e06c75",
    orange = "#d19a66",
    yellow = "#e5c07b",
    cyan = "#56b6c2",
    darkbg = "#21252b",
    lightbg = "#3e4451"
}

function M.setup()
    -- Reset all highlighting to default
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    -- Set colorscheme name
    vim.g.colors_name = 'mycolorscheme'

    -- Editor highlighting
    local editor = {
        Normal = { fg = colors.fg, bg = colors.bg },
        LineNr = { fg = colors.gray },
        CursorLine = { bg = colors.lightbg },
        CursorLineNr = { fg = colors.fg },
        SignColumn = { bg = colors.bg },
        StatusLine = { fg = colors.fg, bg = colors.darkbg },
        VertSplit = { fg = colors.gray, bg = colors.bg },
        Search = { fg = colors.bg, bg = colors.yellow },
        Visual = { bg = colors.lightbg },
    }

    -- Syntax highlighting (basic)
    local syntax = {
        Comment = { fg = colors.gray, italic = true },
        String = { fg = colors.green },
        Number = { fg = colors.orange },
        Keyword = { fg = colors.purple },
        Function = { fg = colors.blue },
        Operator = { fg = colors.cyan },
        Type = { fg = colors.yellow },
    }

    -- Treesitter highlighting
    local treesitter = {
        -- Basic syntax
        ["@variable"] = { fg = colors.fg },
        ["@function"] = { fg = colors.blue },
        ["@function.call"] = { fg = colors.blue },
        ["@method"] = { fg = colors.blue },
        ["@method.call"] = { fg = colors.blue },
        ["@constructor"] = { fg = colors.yellow },
        ["@parameter"] = { fg = colors.orange },
        ["@keyword"] = { fg = colors.purple, bold = true },
        ["@string"] = { fg = colors.green },
        ["@number"] = { fg = colors.orange },
        ["@boolean"] = { fg = colors.orange, bold = true },
        ["@type"] = { fg = colors.yellow, bold = true },
        ["@property"] = { fg = colors.cyan },
        ["@field"] = { fg = colors.cyan },
        ["@attribute"] = { fg = colors.purple },
        ["@comment"] = { fg = colors.gray, italic = true },
        ["@punctuation"] = { fg = colors.fg },
        ["@tag"] = { fg = colors.red },
        ["@tag.attribute"] = { fg = colors.orange },
        ["@tag.delimiter"] = { fg = colors.gray },

        -- Golang specific
        ["@type.builtin.go"] = { fg = colors.yellow, bold = true },
        ["@channel_type"] = { fg = colors.magenta, bold = true },
        ["@keyword.return.go"] = { fg = colors.purple, bold = true },
        ["@keyword.function.go"] = { fg = colors.purple, bold = true },
        ["@keyword.operator.go"] = { fg = colors.purple, bold = true },
        ["@type.qualifier.go"] = { fg = colors.purple, bold = true },
        ["@variable.builtin.go"] = { fg = colors.red, bold = true },
        ["@constant.builtin.go"] = { fg = colors.orange, bold = true },
        ["@field.go"] = { fg = colors.cyan },
        ["@method.go"] = { fg = colors.blue, bold = true },
        ["@function.builtin.go"] = { fg = colors.blue, bold = true },
        ["@keyword.import.go"] = { fg = colors.purple, bold = true },
        ["@keyword.package.go"] = { fg = colors.purple, bold = true },
        ["@keyword.interface.go"] = { fg = colors.purple, bold = true },
        ["@keyword.struct.go"] = { fg = colors.purple, bold = true },
        ["@keyword.defer.go"] = { fg = colors.purple, bold = true },
        -- Add multiple possible capture groups for chan
        ["@type.chan.go"] = { fg = colors.magenta, bold = true },
        ["@keyword.chan.go"] = { fg = colors.magenta, bold = true },
        ["@chan.go"] = { fg = colors.magenta, bold = true },
        ["@operator.chan.go"] = { fg = colors.magenta, bold = true },
        ["@type.operator.chan.go"] = { fg = colors.magenta, bold = true },
        ["@keyword.select.go"] = { fg = colors.purple, bold = true },
        ["@keyword.range.go"] = { fg = colors.purple, bold = true },
    }

    -- Apply highlights
    for group, settings in pairs(editor) do
        vim.api.nvim_set_hl(0, group, settings)
    end
    
    for group, settings in pairs(syntax) do
        vim.api.nvim_set_hl(0, group, settings)
    end
    
    for group, settings in pairs(treesitter) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
