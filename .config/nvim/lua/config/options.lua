-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.netrw_sort_sequence = "[./], [../], *"
vim.g.tmux_navigator_no_mappings = 1

local opt = vim.opt

opt.tabstop = 4
opt.colorcolumn = "80"
