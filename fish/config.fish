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

# Manually add env variables to start with v0.12.4 to increase startup time
set -x NVM_BIN /Users/matt/.nvm/versions/node/v0.12.4/bin
set -x NVM_DIR /Users/matt/.nvm
set -x NVM_IOJS_ORG_MIRROR https://iojs.org/dist
set -x NVM_IOJS_ORG_VERSION_LISTING https://iojs.org/dist/index.tab
set -x NVM_NODEJS_ORG_MIRROR https://nodejs.org/dist
set -x NVM_PATH /Users/matt/.nvm/versions/node/v0.12.4/lib/node
set PATH /Users/matt/.nvm/versions/node/v0.12.4/bin $PATH

set -x NVM_DIR ~/.nvm
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


