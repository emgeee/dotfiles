#!/bin/bash

window_state() {
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/icons.sh"

  WINDOW=$(yabai -m query --windows --window)
  read -r floating split parent fullscreen sticky stack_index \
    <<<$(echo "$WINDOW" | jq -rc '.["is-floating", "split-type", "has-parent-zoom", "has-fullscreen-zoom", "is-sticky", "stack-index"]')

  STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')

  COLOR=$BAR_BORDER_COLOR
  ICON=""

  # Configure window icon
  if [[ $floating == "true" ]]; then
    ICON+="􀶣"
    COLOR=$RED
  elif [[ $parent == "true" ]]; then
    ICON+="􁈔"
    COLOR=$GREEN
  elif [[ $fullscreen == "true" ]]; then
    ICON+="􀏒"
    COLOR=$BLUE
  elif [ $STACK_INDEX -gt 0 ]; then
		ICON+=$YABAI_STACK
		COLOR=$MAGENTA

    LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    # If there's only one window in the stack display 1/1
    if [ -z "$LAST_STACK_INDEX" ]; then
      STACK_INDEX=1
      LAST_STACK_INDEX=1
    fi
    LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
  elif [[ $split == "vertical" ]]; then
    ICON+="􀧉"
    COLOR=$WHITE
  elif [[ $split == "horizontal" ]]; then
    ICON+="􀧋"
    COLOR=$WHITE
  else
    ICON+="􀏄"
    COLOR=$WHITE
  fi

  args=(--bar border_color=$COLOR --animate sin 10 --set $NAME icon.color=$COLOR)

  [ -z "$LABEL" ] && args+=(label.width=0) ||
    args+=(label="$LABEL" label.width=40)

  [ -z "$ICON" ] && args+=(icon.width=0) ||
    args+=(icon="$ICON" icon.width=30)

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  yabai -m window --toggle float
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
