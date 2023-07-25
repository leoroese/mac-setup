local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move line up or down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Remaps to not overwrite register
keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])
keymap.set({ "n", "v" }, "<leader>c", [["_c]])

keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")

-- Sessionizer from within vim
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


local opts = { noremap = true, silent = true }
-- Tmux navigation between panes and tmux windows
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)


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

keymap.set("n", "<leader>uo", ":lua ToggleLightDarkColorScheme()<CR>")
