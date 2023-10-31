#!/bin/bash
# Get the macOS interface style (light or dark)
os_theme=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')

# Set the tmux theme and catppuccin flavour
if [[ $os_theme == "true" ]]; then
	# The system is in dark mode
    tmux source-file ~/.tmux/.tmux_dark.conf
else
	# The system is in light mode
    tmux source-file ~/.tmux/.tmux_light.conf
fi
