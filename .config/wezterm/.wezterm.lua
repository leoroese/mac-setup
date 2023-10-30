-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Tokyonight Moon"
		-- return "Snazzy"
		return "Dracula"
	else
		return "Catppuccin Latte"
	end
end

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		overrides.window_background_opacity = appearance == "Dark" and 0.85 or 1
		overrides.text_background_opacity = appearance == "Dark" and 0.7 or 0.45
		window:set_config_overrides(overrides)
	end
end)

-- font
-- config.font = wezterm.font("FiraCode Nerd Font", { weight = "Regular", stretch = "Normal", italic = false })
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0
config.enable_tab_bar = false

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- jump to end of lines https://mariusschulz.com/blog/keyboard-shortcuts-for-jumping-and-deleting-in-iterm2
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ SendString = "\x01" }) },
	{ key = "RightArrow", mods = "CMD", action = wezterm.action({ SendString = "\x05" }) },
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.,
}

-- and finally, return the configuration to wezterm
return config
