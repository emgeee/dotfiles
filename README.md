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


`ln -s yabai/skhdrc ~/.skhdrc`
`ln -s yabai/yabairc ~/.yabairc`
`ln -s aerospace/ ~/.config/aerospace`
`ln -s fish/ ~/.config/fish`
`ln -s kitty/ ~/.config/kitty`
`ln -s nvim/ ~/.config/nvim`
`ln -s karabiner/ ~/.config/karabiner`
