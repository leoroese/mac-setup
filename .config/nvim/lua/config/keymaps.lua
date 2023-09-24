-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>pv", vim.cmd.Ex)

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Remaps to not overwrite register
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", [["_d]])
map({ "n", "v" }, "<leader>c", [["_c]])

map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")

-- Sessionizer from within vim
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

local opts = { noremap = true, silent = true }
--
-- Tmux navigation between panes and tmux windows
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)

local function check_appearance_mode()
  local cmd = "defaults read -g AppleInterfaceStyle 2>/dev/null"
  local handle = io.popen(cmd)
  local mode = handle:read("*all")
  handle:close()

  if mode:match("Dark") then
    return "dark"
  else
    return "light"
  end
end

function ToggleLightDarkColorScheme()
  local appearance = check_appearance_mode()
  if appearance == "dark" then
    vim.cmd("colorscheme onedark")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end
end

map("n", "<leader>uo", ":lua ToggleLightDarkColorScheme()<CR>")
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
