#!/bin/bash

yabai_space=(
	icon.width=0
	label.width=0
	script="$PLUGIN_DIR/yabai_space.sh"
	icon.font="$FONT:Bold:16.0"
	display=active
)

sketchybar --add event window_focus \
	--add item yabai_space left \
	--set yabai_space "${yabai_space[@]}" \
	--subscribe yabai_space window_focus \
	mouse.clicked


yabai_window=(
	icon.width=0
	label.width=0
	script="$PLUGIN_DIR/yabai_window.sh"
	icon.font="$FONT:Bold:16.0"
	display=active
)

sketchybar --add event window_focus \
	--add item yabai_window left \
	--set yabai_window "${yabai_window[@]}" \
	--subscribe yabai_window window_focus \
	mouse.clicked
