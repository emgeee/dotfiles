#!/usr/bin/env python3
import json
import pprint
import subprocess
import time

pp = pprint.PrettyPrinter()


# Display UUIDs
aux_screen_uuid = "37D8832A-2D66-02CA-B9F7-8F30A301B230"  # MBP 15" screen ID
home_screen_uuid = "6EC90C89-CBE4-4BC6-A43B-56FAB7623884"

# App names to move
aux_app_names = [
    "Messages",
    "Discord",
    "Slack",
    "WhatsApp",
    "Signal",
    "Telegram",  # Messaging apps
    "Spotify",
    "KeePassXC",
    "Obsidian",
    "Docker Desktop",  # Dev tools
]

time.sleep(1)

# Fetch auxiliary screen information and set layout to stack
aux_screen = subprocess.run(
    ["yabai", "-m", "query", "--displays"], capture_output=True, text=True
)
aux_screen_data = json.loads(aux_screen.stdout)
aux_screen_info = list(
    [screen for screen in aux_screen_data if screen["uuid"] == aux_screen_uuid]
)
if aux_screen_info:
    aux_screen_space = aux_screen_info[0]
    pp.pprint(aux_screen_info)
    subprocess.run(
        ["yabai", "-m", "space", str(aux_screen_space['spaces'][0]), "--layout", "stack"])

# Move specified apps to the auxiliary display
running_apps = json.loads(
    subprocess.run(
        ["yabai", "-m", "query", "--windows"], capture_output=True, text=True
    ).stdout
)

pp.pprint([a['app'] for a in running_apps])


def filter_app(app):
    return app['app'].replace('\u200e', '') in aux_app_names


apps_to_move = list(filter(filter_app, running_apps))
for app in apps_to_move:
    print(f"moving {app['app']}")
    subprocess.run(
        [
            "yabai",
            "-m",
            "window",
            str(app["id"]),
            "--space",
            str(aux_screen_space),
        ]
    )

# Change audio output to USB speakers if home screen is detected
home_screen = next(
    (screen for screen in aux_screen_data if screen["uuid"]
     == home_screen_uuid),
    None,
)
if home_screen:
    subprocess.run(["SwitchAudioSource", "-s", "USB Audio DAC   "])

subprocess.run(["sketchybar", "--trigger", "window_focus"])
