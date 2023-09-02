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
  colorscheme = "tokyonight"
  linetheme = "tokyonight"
else
  colorscheme = "catppuccin-latte"
  linetheme = "onelight"
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
