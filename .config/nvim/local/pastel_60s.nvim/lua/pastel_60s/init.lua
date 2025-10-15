-- local/pastel-60s.nvim/lua/pastel_60s/init.lua
-- This is the main module for our theme.

local M = {}

-- This function contains all the logic to apply the colorscheme.
function M.load()
  -- Protect against running this file twice or after another theme
  if vim.g.colors_name then
    vim.cmd.highlight 'clear'
  end

  -- Set the colorscheme name
  vim.g.colors_name = 'pastel_60s'

  -- Load the color palette and highlight definitions from other modules
  local palette = require('pastel_60s.palette').palette
  local highlights = require('pastel_60s.highlights').get_highlights(palette)

  -- Apply all the highlight groups
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
