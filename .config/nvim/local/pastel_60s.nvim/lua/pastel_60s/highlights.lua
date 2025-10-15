-- local/pastel-60s.nvim/lua/pastel_60s/highlights.lua
-- This file defines all the highlight groups for the theme.

-- 1. Create the module table
local M = {}

-- 2. Define the function and attach it to the module table
function M.get_highlights(palette)
  return {
    -- Normal text
    Normal = { fg = palette.fg, bg = palette.bg},

    -- UI Elements
    LineNr = { fg = palette.comment },
    CursorLineNr = { fg = palette.yellow, bold = true },
    SignColumn = { fg = palette.comment },
    Visual = { bg = palette.selection },
    ColorColumn = { bg = palette.dark_bg },
    VertSplit = { fg = palette.dark_bg, bg = 'none' },
    StatusLine = { fg = palette.fg, bg = palette.dark_bg },
    StatusLineNC = { fg = palette.comment, bg = palette.dark_bg },
    TabLine = { fg = palette.comment, bg = palette.dark_bg },
    TabLineSel = { fg = palette.fg, bg = palette.bg },
    TabLineFill = { bg = palette.dark_bg },
    Pmenu = { fg = palette.fg, bg = palette.dark_bg },
    PmenuSel = { bg = palette.selection },
    PmenuThumb = { bg = palette.comment },

    -- Syntax Groups
    Comment = { fg = palette.comment, italic = true },
    Constant = { fg = palette.purple },
    String = { fg = palette.green },
    Character = { fg = palette.green },
    Number = { fg = palette.orange },
    Boolean = { fg = palette.orange },
    Float = { fg = palette.orange },
    Identifier = { fg = palette.cyan },
    Function = { fg = palette.blue, bold = true },
    Statement = { fg = palette.pink },
    Conditional = { fg = palette.pink },
    Repeat = { fg = palette.pink },
    Label = { fg = palette.pink },
    Operator = { fg = palette.pink },
    Keyword = { fg = palette.pink },
    Exception = { fg = palette.pink },
    PreProc = { fg = palette.yellow },
    Include = { fg = palette.yellow },
    Define = { fg = palette.yellow },
    Macro = { fg = palette.yellow },
    Type = { fg = palette.yellow },
    StorageClass = { fg = palette.yellow },
    Structure = { fg = palette.yellow },
    Typedef = { fg = palette.yellow },
    Special = { fg = palette.purple },
    Underlined = { underline = true },
    Error = { fg = palette.red, bg = palette.dark_bg, bold = true },
    Todo = { fg = palette.bg, bg = palette.yellow, bold = true },
    Title = { fg = palette.blue, bold = true },

    -- Treesitter Groups
    ["@text"] = { fg = palette.fg },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { italic = true },
    ["@text.underline"] = { underline = true },
    ["@text.title"] = { fg = palette.blue, bold = true },
    ["@comment"] = { fg = palette.comment, italic = true },
    ["@punctuation.delimiter"] = { fg = palette.fg },
    ["@punctuation.bracket"] = { fg = palette.fg },
    ["@string"] = { fg = palette.green },
    ["@string.escape"] = { fg = palette.pink },
    ["@character"] = { fg = palette.green },
    ["@number"] = { fg = palette.orange },
    ["@boolean"] = { fg = palette.orange },
    ["@float"] = { fg = palette.orange },
    ["@function"] = { fg = palette.blue },
    ["@function.macro"] = { fg = palette.purple },
    ["@keyword"] = { fg = palette.pink },
    ["@keyword.function"] = { fg = palette.pink },
    ["@operator"] = { fg = palette.pink },
    ["@conditional"] = { fg = palette.pink },
    ["@repeat"] = { fg = palette.pink },
    ["@include"] = { fg = palette.blue },
    ["@constructor"] = { fg = palette.yellow },
    ["@variable"] = { fg = palette.fg },
    ["@variable.builtin"] = { fg = palette.purple },
    ["@constant"] = { fg = palette.purple },
    ["@constant.builtin"] = { fg = palette.purple },
    ["@type"] = { fg = palette.yellow },
    ["@type.builtin"] = { fg = palette.yellow, bold = true },
    ["@property"] = { fg = palette.cyan },
    ["@namespace"] = { fg = palette.yellow },
    ["@field"] = { fg = palette.cyan },
    ["@tag"] = { fg = palette.pink },
    ["@tag.attribute"] = { fg = palette.cyan },
    ["@tag.delimiter"] = { fg = palette.pink },
  }
end

-- 3. Return the entire module table at the end
return M
