require("settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins with lazy.nvim
require("lazy").setup("plugins")

vim.lsp.enable('gopls')

if vim.g.neovide then
    vim.g.neovide_cursor_trail_size = 0.0
    vim.g.neovide_cursor_animation_length = 0 
    vim.g.neovide_cursor_short_animation_length = 1
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_fullscreen = true
    vim.opt.linespace = 5
end

--vim.cmd.colorscheme("gruber-darker")
--vim.cmd([[colorscheme modus]]) -- modus_operandi, modus_vivendi
