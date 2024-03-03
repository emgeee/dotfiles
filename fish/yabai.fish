
function yabai_is_floating
  echo (yabai -m query --windows --window | jq -r '."is-floating"')
end

function yabai_set_float
  if test (yabai_is_floating) = "false"
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
