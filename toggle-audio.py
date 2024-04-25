#!/usr/bin/env python3

"""
Wrapper around SwitchAudio that toggles to a new output device based off the current device
requires SwitchAudioSource

> brew install switchaudio-osx
> brew install blueutil
"""

import subprocess
import time

SWITCH_AUDIO_PATH = "/opt/homebrew/bin/SwitchAudioSource"
BLUEUTIL_PATH = "/opt/homebrew/bin/blueutil"

AIRPODS_BLUETOOTH_ADDRESS = "00-f3-9f-64-2a-0e"

audio_source_mappings = {
    "MacBook Pro Speakers": "Matt’s AirPods Pro",
    "Matt’s AirPods Pro": "MacBook Pro Speakers",
}


def is_bluetooth_connected():
    output = subprocess.run(
        [BLUEUTIL_PATH, "--is-connected", AIRPODS_BLUETOOTH_ADDRESS],
        capture_output=True,
    )
    is_connected = bool(int(str(output.stdout, "utf-8").strip()))
    return is_connected


def get_current_device():
    output = subprocess.run([SWITCH_AUDIO_PATH, "-c"], capture_output=True)
    current_device = str(output.stdout, "utf-8").strip()
    return current_device


def toggle_bluetooth():
    current_device = get_current_device()
    subprocess.run(
        [SWITCH_AUDIO_PATH, "-s", audio_source_mappings[current_device]])


if __name__ == "__main__":
    if not is_bluetooth_connected():
        print("connecting via bluetooth")
        original_current_device = get_current_device()
        subprocess.run(
            [BLUEUTIL_PATH, "--connect", AIRPODS_BLUETOOTH_ADDRESS], capture_output=True
        )
        time.sleep(1)
        toggle_bluetooth()
        time.sleep(1)
        # For some reason the audio might switch back so ensure output is properly set
        if get_current_device() == original_current_device:
            toggle_bluetooth()
    else:
        toggle_bluetooth()

    # print(f"Switching audio to {get_current_device()}")
