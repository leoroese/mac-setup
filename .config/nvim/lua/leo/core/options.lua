vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    astro = "astro",
  },
  filename = {},
  pattern = {},
})

vim.g.netrw_sort_sequence = "[./], [../], *"
vim.g.tmux_navigator_no_mappings = 1

local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 4 -- number column width

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- colors
opt.termguicolors = true

opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- swapfile
opt.swapfile = false -- creates a swap file

-- cursors
opt.pumheight = 10 -- height of pop up menu
opt.scrolloff = 8 -- minimium number of lines above and below the cursor
opt.sidescrolloff = 8 -- minimum number of columns on the left and right of the cursor

-- misc
opt.showmode = false -- won't show the mode in the command bar
opt.signcolumn = "yes" -- always show the sign column
opt.undofile = true -- persistent undo
opt.conceallevel = 0 -- to show text normally
opt.guicursor = "n-v-c-i:block" -- cursor style in different modes, see :help 'guicursor'
