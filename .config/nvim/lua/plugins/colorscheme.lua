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
  colorscheme = "tokyonight-moon"
else
  colorscheme = "catppuccin-latte"
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
