-- local/pastel-60s.nvim/lua/pastel_60s/palette.lua
-- A 1960s pastel palette inspired by the Gruvbox theme.

local M = {}

M.palette = {
  -- Backgrounds and Foreground
  bg = '#f4e9d8',        -- A warm, creamy paper color
  dark_bg = '#e8dace',    -- Slightly darker for UI elements like statuslines
  selection = '#d5c7b3', -- Muted beige for selections
  fg = '#5a524c',        -- A dark, soft brown for main text
  comment = '#a19589',   -- A gentle, muted taupe

  -- Syntax Colors
  pink = '#e88388',      -- Soft cherry blossom for keywords and statements
  orange = '#f5a578',    -- Pastel apricot for numbers and constants
  yellow = '#f0d379',    -- Buttery yellow for types and modules
  green = '#8bbd8b',     -- Sage green for strings and comments
  cyan = '#7ab8bb',      -- Muted teal for identifiers
  blue = '#7e9cd8',      -- Periwinkle blue for functions
  purple = '#b398b3',    -- Dusty lilac for special keywords and constants

  -- Utility Colors
  red = '#d98585',       -- A slightly stronger, soft red for errors
}

return M
