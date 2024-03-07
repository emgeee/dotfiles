dotfiles
========

Just some of my dotfiles

## Tmux
Using [tmux package manager](https://github.com/tmux-plugins/tpm)
Install using `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`


## For a new Mac:

- Enable holding ctrl+cmd+click drag to move windows (applications must be restarted after running): `defaults write -g NSWindowShouldDragOnGesture -bool yes`
- Disable windows opening animations: `defaults write -g NSAutomaticWindowAnimationsEnabled -bool false`


- Install Karabiner elements
- Configure a complex Modification to Disable Cmd+H hide:
The following will disable cmd+H for all applications except for Kitty, because we use that hotkey to change window panes

```json
{
    "description": "Disable Cmd+H Hide (rev 2)",
    "manipulators": [
        {
            "conditions": [
                {
                    "bundle_identifiers": [
                        "^net\\.kovidgoyal\\.kitty$"
                    ],
                    "type": "frontmost_application_unless"
                }
            ],
            "description": "",
            "from": {
                "key_code": "h",
                "modifiers": {
                    "mandatory": [
                        "command"
                    ]
                }
            },
            "type": "basic"
        }
    ]
}
```

For the following programs you must remap the Hide window to a different key to free up Cmd+H (https://superuser.com/questions/1043596/mac-osx-remove-hide-window-keyboard-shortcut)
- Kitty
- vscode

*Note*: these programs are also listed in the karabiner elements config for "Disable Cmd+H Hide (rev 2)"



## Set up proper symlinks
```
ln -s (pwd)/yabai/skhdrc ~/.skhdrc;
ln -s (pwd)/yabai/yabairc ~/.yabairc;
ln -s (pwd)/yabai/ ~/.config/yabai;
ln -s (pwd)/aerospace/ ~/.config/aerospace;
ln -s (pwd)/fish/ ~/.config/fish;
ln -s (pwd)/kitty/ ~/.config/kitty;
ln -s (pwd)/nvim/ ~/.config/nvim;
ln -s (pwd)/karabiner/ ~/.config/karabiner;
ln -s (pwd)/sketchybar/ ~/.config/sketchybar;
```
