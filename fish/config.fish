# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

### Begin custom fish customization

# erase any default greeting message
set --erase fish_greeting

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

# Configure nvm
# manually set up paths to increase startup time
set -l NODE_TYPE node
set -l NODE_VERSION v4.1.0
# set -l NODE_VERSION v0.12.7

set -x NVM_BIN /Users/matt/.nvm/versions/$NODE_TYPE/$NODE_VERSION/bin
set -x NVM_PATH /Users/matt/.nvm/versions/$NODE_TYPE/$NODE_VERSION/lib/node
set -U fish_user_paths /Users/matt/.nvm/versions/$NODE_TYPE/$NODE_VERSION/bin $PATH

set -x NVM_DIR ~/.nvm

set -x ANDROID_HOME /usr/local/opt/android-sdk

source ~/.config/fish/nvm-wrapper/nvm.fish

## This is pretty slow but works
# nvm use default 2>&1 >/dev/null

### End custom fish config
# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Load fish plugins
Theme 'robbyrussell'
Plugin 'theme'
Plugin 'osx'
Plugin 'node'
Plugin 'tmux'
Plugin 'vi-mode'
Plugin 'brew'


