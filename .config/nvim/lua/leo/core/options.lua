vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
    astro = "astro",
    vue = "vue",
  },
  filename = {},
  pattern = {},
})

vim.g.netrw_sort_sequence = "[./], [../], *"
vim.g.netrw_keepdir = 0
vim.g.tmux_navigator_no_mappings = 1

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local options = {
  autoindent = true, -- copy indent from current line when starting a new line
  backup = false, -- creates a backup file
  backupskip = { "/tmp/*", "/private/tmp/*" },
  backspace = { "indent", "eol", "start" }, -- backspace through everything in insert mode
  breakindent = true, -- wrap lines with indent
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  confirm = true, -- confirm to save changes before exiting modified buffer
  cursorline = false, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  fillchars = { eob = " " }, -- change the character at the end of buffer
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  guicursor = "n-v-c-i:block", -- cursor style in different modes, see :help 'guicursor'
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true, -- make search act like search in modern browsers
  inccommand = "split", -- incrementally show result of substitute
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  ruler = false, -- Don't show the ruler
  scrolloff = 8, -- Makes sure there are always eight lines of context
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showcmd = true, -- Don't show the command in the last line
  showtabline = 0, -- always show tabs
  sidescrolloff = 8, -- Makes sure there are always eight lines of context
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  splitkeep = "cursor", -- when opening a new split, keep the cursor focused in the current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}
for k, v in pairs(options) do
  vim.opt[k] = v
end
