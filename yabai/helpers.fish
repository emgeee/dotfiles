
set SKETCHYBAR_ENABLED true

function yabai_update_sketchybar
  if $SKETCHYBAR_ENABLED
    sketchybar --trigger window_focus
  end
end

## Functions to help with yabai
function yabai_is_floating
  echo (yabai -m query --windows --window | jq -r '."is-floating"')
end

function yabai_set_float
  set floating_status $argv[1]

  # Validate the input (optional)
  if not string match -q -r '(true|false)' $floating_status
    echo "Invalid argument. Please provide either 'true' or 'false'."
    return 1
  end

  if test (yabai_is_floating) != $floating_status
    yabai -m window --toggle float;
  end

  yabai_update_sketchybar
end

function yabai_toggle_floating
  yabai -m window --toggle float;

  if test (yabai_is_floating) = "false"
    # Resize the window slightly to make it clear it's floating
    yabai -m window --resize top_left:10:10
    yabai -m window --resize bottom_right:-10:-10
  end

  yabai_update_sketchybar
end

# Iterate through all windows and set whether floating or not
function yabai_set_all_float
  set floating_status $argv[1]

  # Store the current focused window id
  set current_window_id (yabai -m query --windows --window | jq '.id')

  set json_output (yabai -m query --windows --display)

  # Use jq to filter and extract data
  for window_id in (echo $json_output | \
      jq --argjson status "$floating_status" '.[] | select(.["is-floating"] == $status | not) | .id')

    yabai -m window --focus $window_id
    yabai -m window --toggle float
  end

  yabai -m window --focus $current_window_id
  yabai_update_sketchybar
end

# Hot key to stack windows
function yabai_stack_window
  set direction $argv[1]

  # Store the current focused window id
  set current_window_id (yabai -m query --windows --window | jq '.id')

  yabai_set_float false
  yabai -m window --stack $direction

  yabai -m window --focus $current_window_id

  yabai_update_sketchybar
  skhd -k "escape"
end

# Move a window and stack it on top of another window
function yabai_warp_mouse
  echo "running warp_mouse"

  set current_window (yabai -m query --windows --window)

  if test -z "$current_window"
    echo "No window focused" >&2
    skhd -k "escape"
    return
  end


  set current_window_id (echo $current_window | jq '.id')
  set current_window_app (echo $current_window | jq '.app')
  set current_window_display_id (echo $current_window | jq '.display')

  set mouse_hover_window (yabai -m query --windows --window mouse)
  if test -n "$mouse_hover_window"
    echo "hovering over a window!!"
    set mouse_hover_window_id (echo $mouse_hover_window | jq '.id')
    set mouse_hover_window_app (echo $mouse_hover_window | jq '.app')
    set mouse_hover_display_id (echo $mouse_hover_window | jq '.display')

    if test $current_window_id = $mouse_hover_window_id
      echo "current window and hover window are the same" >&2
      skhd -k "escape"
      return
    end
  else
    echo "hovering over no window, fetching mouse hover display id..."
    set mouse_hover_display_id (yabai -m query --displays --display mouse | jq '.id')
    echo "display id" $mouse_hover_display_id

    if test -z "$mouse_hover_display_id"
      echo "Can't find display under mouse..." >&2
      skhd -k "escape"
      return
    end
  end

  echo "current window: " $current_window_app "id:" $current_window_id "display_id:" $current_window_display_id
  echo "mouse window: " $mouse_hover_window_app "id:" $mouse_hover_window_id "display_id:" $mouse_hover_display_id

  # float the window first to remove it from any stacks it may be part of
  yabai_set_float true

  # Move window to different display if need be
  # This step appears to be required for windows to stack properly
  if test $current_window_display_id != $mouse_hover_display_id
    echo "moving window to new display " $mouse_hover_display_id
    yabai -m window $current_window_id --display $mouse_hover_display_id
  end

  # re-focus the current window before setting it's float status to false
  yabai -m window --focus $current_window_id
  yabai_set_float false

  # Finally stack the window and re-focus it
  if test -n "$mouse_hover_window_id"
    yabai -m window --stack $mouse_hover_window_id
    yabai -m window --focus stack.recent
  end

  yabai_update_sketchybar
  skhd -k "escape"
end

function yabai_restart
  terminal-notifier -message "restarting yabai" -title "skhd"
  yabai --restart-service

  skhd -k "escape"
end

function yabai_display_added
  # List the Ids of screens that should be used for aux puproses (usually the laptop's screen)
  # fetch uuids with `yabai -m query --displays`
  set aux_screen_uuid "37D8832A-2D66-02CA-B9F7-8F30A301B230"

  # Add app names that should be moved
  set aux_app_names \
    "Spotify" \
    "Discord" \
    "Slack" \
    "Messages" \
    "KeePassXC" \
    "Obsidian"

  # Find the Aux screen and configure to be a stack orientation (as opposed to bsp)
  set aux_screen (yabai -m query --displays | jq --arg uuid "$aux_screen_uuid" '.[] | select(.uuid == $uuid)')
  set aux_screen_space (echo $aux_screen | jq -rj .spaces[0] )
  yabai -m space $aux_screen_space --layout stack

  # Move specified apps to the aux display
  # yabai -m query --windows | jq '.[] | {app: .app, id: .id}'

  for app in $aux_app_names
    set app_id (yabai -m query --windows | jq --arg app_name "$app" '.[] | select(.app == $app_name) | .id')

    if test -n "$app_id"
      echo "moving $app ($app_id) to space $aux_screen_space"
      yabai -m window $app_id --space $aux_screen_space
    else
      echo "$app not running"
    end
  end

  yabai_update_sketchybar
end
