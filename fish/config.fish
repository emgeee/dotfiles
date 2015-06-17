# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

Theme 'robbyrussell'
Plugin 'theme'
Plugin 'git'
Plugin 'node'
Plugin 'tmux'
Plugin 'autojump'
Plugin 'vi-mode'
Plugin 'brew'


# PATH
set -e fish_user_paths

# # prepend ~/.bin/
if test -e $HOME/.bin
  set -U fish_user_paths $HOME/.bin $PATH
end

# # prepend /usr/local/bin for brew on MAX OSX
if test -e /usr/local/bin
  set -U fish_user_paths /usr/local/bin $PATH
end

# # prepend /usr/local/sbin for brew on MAX OSX
if test -e /usr/local/sbin
  set -U fish_user_paths /usr/local/sbin $PATH
end

# Universal environment variables
set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim

if type vimpager >/dev/null 2>&1
  set -Ux PAGER vimpager
end

function sudo_update_locate
  echo "updating locate db..."
  sudo /usr/libexec/locate.updatedb
end

source ~/.config/fish/nvm-wrapper/nvm.fish
