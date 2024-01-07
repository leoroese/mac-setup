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

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "meuter/lualine-so-fancy.nvim" },
  config = function()
    local icons = require("leo.core.icons")
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- configure lualine with modified theme
    local line_theme
    if check_appearance_mode() == "dark" then
      line_theme = "tokyonight"
    else
      line_theme = "onelight"
    end
    lualine.setup({
      options = {
        theme = line_theme,
        globalstatus = true,
        icons_enabled = true,
        -- component_separators = { left = "│", right = "│" },
        component_separators = { left = icons.ui.DividerRight, right = icons.ui.DividerLeft },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "alfa-nvim",
            "help",
            "neo-tree",
            "Trouble",
            "spectre_panel",
            "toggleterm",
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          "fancy_branch",
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 2 for full path
            symbols = {
              modified = "  ",
              -- readonly = "  ",
              -- unnamed = "  ",
            },
          },
          { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "fancy_searchcount" },
        },
        lualine_x = {
          "fancy_lsp_servers",
          "fancy_diff",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        -- lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "lazy" },
    })
  end,
}
