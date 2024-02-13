dotfiles
========

Just some of my dotfiles

Tmux
---
Using [tmux package manager](https://github.com/tmux-plugins/tpm)
Install using `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`


For a new Mac:

- Enable holding ctrl+cmd+click drag to move windows (applications must be restarted after running): `defaults write -g NSWindowShouldDragOnGesture -bool yes`
- Disable windows opening animations: `defaults write -g NSAutomaticWindowAnimationsEnabled -bool false`


- Install Karabiner elements


`ln -s (pwd)/yabai/skhdrc ~/.skhdrc`
`ln -s (pwd)/yabai/yabairc ~/.yabairc`
`ln -s (pwd)/yabai/ ~/.config/yabai`
`ln -s (pwd)/aerospace/ ~/.config/aerospace`
`ln -s (pwd)/fish/ ~/.config/fish`
`ln -s (pwd)/kitty/ ~/.config/kitty`
`ln -s (pwd)/nvim/ ~/.config/nvim`
`ln -s (pwd)/karabiner/ ~/.config/karabiner`
