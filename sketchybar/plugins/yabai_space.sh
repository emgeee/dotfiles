#!/bin/bash

window_state() {
	source "$CONFIG_DIR/colors.sh"
	source "$CONFIG_DIR/icons.sh"

	WINDOW=$(yabai -m query --windows --window)
	STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')

	COLOR=$ICON_COLOR
	ICON=""

	read -r space_type <<<$(yabai -m query --spaces --space | jq -rc '.["type"]')

	# Configure spaces icon
	case $space_type in
	"bsp") 
		ICON+=$YABAI_GRID
    ;;
	"float")
		ICON+=$YABAI_FLOAT
    COLOR=$RED
    ;;
	"stack")
		LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
		ICON+=$YABAI_STACK
		LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
		COLOR=$MAGENTA
    ;;
	esac

	args=(--animate sin 10 --set $NAME icon.color=$COLOR)

	[ -z "$LABEL" ] && args+=(label.width=0) ||
		args+=(label="$LABEL" label.width=40)

	[ -z "$ICON" ] && args+=(icon.width=0) ||
		args+=(icon="$ICON" icon.width=30)

	sketchybar -m "${args[@]}"
}

mouse_clicked() {
  yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end');

	window_state
}

case "$SENDER" in
"mouse.clicked")
	mouse_clicked
	;;
"window_focus")
	window_state
	;;
esac
