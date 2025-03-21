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
- Configure a complex Modification to Disable Cmd+H hide (check [karabiner/karabiner.json](karabiner/karabiner.json))


For the following programs you must remap the Hide window to a different key to free up Cmd+H (https://superuser.com/questions/1043596/mac-osx-remove-hide-window-keyboard-shortcut)
- Kitty
- vscode

*Note*: these programs are also listed in the karabiner elements config for "Disable Cmd+H Hide (rev 2)"

## Homebrew

To restore from the current brewfile: `brew bundle install --file=Brewfile`
To update the current brewfile: `brew bundle dump --force --file=Brewfile`



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
