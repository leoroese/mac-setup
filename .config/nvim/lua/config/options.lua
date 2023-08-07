-- globals
-- vim.g.loaded_matchparen = 1          -- Disable highlight of matching paren
vim.g.netrw_sort_sequence = '[./], [../], *'
vim.g.markdown_recommended_style = 0 -- fix markdown indentation
vim.g.tmux_navigator_no_mappings = 1


local opt = vim.opt

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1         -- Height of the command bar
opt.incsearch = true      -- Makes search act like search in modern browsers
opt.showmatch = true      -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true         -- But show the actual number for the line we're on
opt.ignorecase = true     -- Ignore case when searching...
opt.smartcase = true      -- ... unless there is a capital letter in the query
opt.hidden = true         -- I like having buffers stay around
opt.equalalways = false   -- I don't like my windows changing all the time
opt.splitright = true     -- Prefer windows splitting to the right
opt.splitbelow = true     -- Prefer windows splitting to the bottom
opt.updatetime = 100      -- Make updates happen faster
opt.hlsearch = true       -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10        -- Make it so there are always ten lines below my cursor

-- opt.smoothscroll = true

-- Cursorline highlighting control
--  Only have it on in the active buffer
opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "a"

-- Save undo history
opt.undofile = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

opt.colorcolumn = "80"

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- From LazyNvim distro that I liked
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.timeoutlen = 300
opt.undolevels = 10000

-- support mdx
vim.filetype.add({
    extension = {
        mdx = "markdown.mdx"
    },
    filename = {},
    pattern = {}
})
