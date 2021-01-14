#!/usr/bin/env python3

"""
Wrapper around SwitchAudio that toggles to a new output device based off the current device
requires SwitchAudioSource

> brew install switchaudio-osx
> brew install blueutil
"""

import time
import sys
import subprocess

SWITCH_AUDIO_PATH = '/usr/local/bin/SwitchAudioSource'
BLUEUTIL_PATH = '/usr/local/bin/blueutil'

SPEAKER_BLUETOOTH_ADDRESS = '68-37-e9-69-74-8c'

audio_source_mappings = {
    'MacBook Pro Speakers': 'Echo Dot-9P9',
    'Echo Dot-9P9': 'MacBook Pro Speakers',
}

def is_bluetooth_connected():
    output = subprocess.run([BLUEUTIL_PATH, '--is-connected', SPEAKER_BLUETOOTH_ADDRESS], capture_output=True)
    is_connected = bool(int(str(output.stdout, 'utf-8').strip()))
    return is_connected

def get_current_device():
    output = subprocess.run([SWITCH_AUDIO_PATH, '-c'], capture_output=True)
    current_device = str(output.stdout, 'utf-8').strip()
    return current_device

def toggle_bluetooth():
    current_device = get_current_device()
    subprocess.run([SWITCH_AUDIO_PATH, '-s', audio_source_mappings[current_device]])


if __name__ == "__main__":
    if not is_bluetooth_connected():
        print("trying to connect to bluetooth")
        original_current_device = get_current_device()
        subprocess.run([BLUEUTIL_PATH, '--connect', SPEAKER_BLUETOOTH_ADDRESS], capture_output=True)
        time.sleep(3)
        toggle_bluetooth()
        time.sleep(3)
        # For some reason the autio might switch back so ensure output is properly set
        if get_current_device() == original_current_device:
            toggle_bluetooth()
    else:
        toggle_bluetooth()

    print("Speaker connected, switching audio")



