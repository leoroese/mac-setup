vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    astro = "astro",
  },
  filename = {},
  pattern = {},
})

vim.g.netrw_sort_sequence = "[./], [../], *"
vim.g.netrw_keepdir = 0
vim.g.tmux_navigator_no_mappings = 1

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- deprecated
vim.g.skip_ts_context_commentstring_module = true

local opt = vim.opt

opt.guicursor = "n-v-c-i:block" -- cursor style in different modes, see :help 'guicursor'

-- clipboard
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes if try to exit with unsaved changes

-- indentation
opt.expandtab = true -- Use spaces instead of tabs, tabs vary on diff editors
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- round indent
opt.tabstop = 2 -- Number of spaces tabs count for

-- show
opt.cursorline = true -- enable highlight of current line
opt.list = true -- show hiden invisible characters

-- search
opt.formatoptions = "jcroqlnt" -- control how nvim auto-formats text
opt.grepformat = "%f:%l:%c:%m" -- format of output
opt.grepprg = "rg --vimgrep" -- program to use for grep command
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "nosplit" -- preview incremental substitute

-- lines
opt.number = true -- show line number
opt.relativenumber = true -- show relative line number
opt.scrolloff = 8 -- minimum number of lines above and below cursor
opt.wrap = false -- Disable line wrap

-- popup
opt.pumblend = 10 -- transparency of popup menu
opt.pumheight = 10 -- maximum number of items in popup menu

-- splits
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- colors
opt.termguicolors = true -- True color support

-- fill
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- general settings
opt.mouse = "a" -- enable mouse support
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.spelllang = { "en" }
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
