-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Snazzy"
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
		overrides.window_frame = {
			active_titlebar_bg = appearance == "Dark" and "#1e1f29" or "#e6e9ef",
		}
		overrides.colors = {
			tab_bar = {
				-- The active tab is the one that has focus in the window
				active_tab = {
					-- The color of the background area for the tab
					bg_color = appearance == "Dark" and "#1e1f29" or "white",
					-- The color of the text for the tab
					fg_color = appearance == "Dark" and "deepskyblue" or "blue",
				},

				-- Inactive tabs are the tabs that do not have focus
				inactive_tab = {
					bg_color = appearance == "Dark" and "1b1032" or "#e6e9ef",
					fg_color = appearance == "Dark" and "#808080" or "silver",

					-- The same options that were listed under the `active_tab` section above
					-- can also be used for `inactive_tab`.
				},

				-- You can configure some alternate styling when the mouse pointer
				-- moves over inactive tabs
				inactive_tab_hover = {
					bg_color = appearance == "Dark" and "#3b3052" or "white",
					fg_color = appearance == "Dark" and "#909090" or "silver",
					italic = true,

					-- The same options that were listed under the `active_tab` section above
					-- can also be used for `inactive_tab_hover`.
				},

				-- The new tab button that let you create new tabs
				new_tab = {
					bg_color = appearance == "Dark" and "#1b1032" or "#e6e9ef",
					fg_color = appearance == "Dark" and "#808080" or "blue",

					-- The same options that were listed under the `active_tab` section above
					-- can also be used for `new_tab`.
				},

				-- You can configure some alternate styling when the mouse pointer
				-- moves over the new tab button
				new_tab_hover = {
					bg_color = appearance == "Dark" and "#3b3052" or "white",
					fg_color = appearance == "Dark" and "#909090" or "blue",
					italic = true,

					-- The same options that were listed under the `active_tab` section above
					-- can also be used for `new_tab_hover`.
				},
			},
		}
		window:set_config_overrides(overrides)
	end
end)

-- font
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Regular", stretch = "Normal", italic = false })
config.font_size = 13.0

config.window_frame = {
	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#1e1f29",

	-- -- The overall background color of the tab bar when
	-- -- the window is not focused
	-- inactive_titlebar_bg = "#1e1f29",
}

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

	-- jump to end of lines https://mariusschulz.com/blog/keyboard-shortcuts-for-jumping-and-deleting-in-iterm2
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ SendString = "\x01" }) },
	{ key = "RightArrow", mods = "CMD", action = wezterm.action({ SendString = "\x05" }) },
}
config.colors = {
	tab_bar = {
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#1e1f29",
			-- The color of the text for the tab
			fg_color = "deepskyblue",
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

-- and finally, return the configuration to wezterm
return config
