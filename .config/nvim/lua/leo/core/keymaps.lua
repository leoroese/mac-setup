-- set leader key to space
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remaps to not overwrite register
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

-- Sessionizer from within vim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

local opts = { noremap = true, silent = true }

-- Tmux navigation between panes and tmux windows
vim.keymap.set("n", "<C-j>", "<cmd>:TmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", "<cmd>:TmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-h>", "<cmd>:TmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-l>", "<cmd>:TmuxNavigateRight<CR>", opts)

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
  local lualine = require("lualine")

  if appearance == "dark" then
    vim.cmd("colorscheme tokyonight-moon")
    lualine.setup({ options = { theme = "tokyonight-moon" } })
  else
    vim.cmd("colorscheme catppuccin-latte")
    lualine.setup({ options = { theme = "onelight" } })
  end
end

vim.keymap.set("n", "<leader>uo", ":lua ToggleLightDarkColorScheme()<CR>", { noremap = true, silent = true })
