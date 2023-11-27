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

local colorscheme
if check_appearance_mode() == "dark" then
  colorscheme = "tokyonight"
else
  colorscheme = "catppuccin-latte"
end

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "storm" },
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
