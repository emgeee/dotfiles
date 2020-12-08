#!/usr/bin/env python3

"""
Wrapper around SwitchAudio that toggles to a new output device based off the current device
requires SwitchAudioSource

> brew install switchaudio-osx
"""

import subprocess

SWITCH_AUDIO_PATH = '/usr/local/bin/SwitchAudioSource'

audio_source_mappings = {
    'MacBook Pro Speakers': 'Echo Dot-9P9',
    'Echo Dot-9P9': 'MacBook Pro Speakers',
}

if __name__ == "__main__":
    output = subprocess.run([SWITCH_AUDIO_PATH, '-c'], capture_output=True)
    current_device = str(output.stdout, 'utf-8').strip()
    output = subprocess.run([SWITCH_AUDIO_PATH, '-s', audio_source_mappings[current_device]])
