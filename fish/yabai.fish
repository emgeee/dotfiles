
function yabai_is_floating
  echo (yabai -m query --windows --window | jq -r '."is-floating"')
end

function yabai_set_float
  if test (yabai_is_floating) = "false"
    yabai -m window --toggle float;
  end
end

function yabai_set_unfloat
  if test (yabai_is_floating) = "true"
    yabai -m window --toggle float;
  end
end

function yabai_toggle_minimize
  if test (yabai_is_floating) = "false"
    yabai -m window --toggle float;
  end
end

function yabai_toggle_floating
  if test (yabai_is_floating) = "true"
    yabai -m window --toggle float;
  else
    yabai -m window --toggle float;
    # Resize the window slightly to make it clear it's floating
    yabai -m window --resize top_left:10:10
    yabai -m window --resize bottom_right:-10:-10
  end
end

function set_floating_for_all_windows
  # Get output of yabai query as JSON
  set floating_status $argv[1]

  set json_output (yabai -m query --windows --display)

  # Use jq to filter and extract data
  for window in (echo $json_output | jq --argjson status "$floating_status" '.[] | select(.["is-floating"] == $status | not) | .id')
    echo $window
    yabai -m window --focus $window 
    yabai -m window --toggle float
  end
end

