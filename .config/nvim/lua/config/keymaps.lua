-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
    vim.cmd("colorscheme tokyonight-moon")
  else
    vim.cmd("colorscheme catppuccin-latte")
  end
end

vim.keymap.set("n", "<leader>uo", ":lua ToggleLightDarkColorScheme()<CR>")

vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" }) -- https://stackoverflow.com/a/42071865/516188

-- Navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- take below line and append to current line with space
vim.keymap.set("n", "J", "mzJ`z")

-- Allow to keep cursor in the middle of half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search terms cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever (delete highlighted word in void register and put current register word)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- search and replace word under cursor in file
vim.keymap.set("n", "<leader>cR", [[:%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>]])

-- next greatest remap ever : asbjornHaland
-- +y is system clipboard so can paste it anywhere
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Same thing but with delete
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Worst place in the universe
vim.keymap.set("n", "Q", "<nop>")
