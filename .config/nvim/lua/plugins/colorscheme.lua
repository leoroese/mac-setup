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
local linetheme
if check_appearance_mode() == "dark" then
    colorscheme = "onedark"
    linetheme = "onedark"
else
    colorscheme = "catppuccin-latte"
    linetheme = "onelight"
end

return {
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        lazy = false,
    },
    {
        "catppuccin/nvim",
        lazy = false
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = linetheme,
                component_separators = '|',
                section_separators = '',
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
