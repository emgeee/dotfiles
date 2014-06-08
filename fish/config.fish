# PATH
set -e fish_user_paths



set fish_theme robbyrussell

set fish_plugins git rails node rbenv tmux autojump vi-mode brew bundler

# # Node/NPM
set -Ux NPM_PACKAGES $HOME/.nvm/v0.10.28
set -gx NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH
if test -e $NPM_PACKAGES/bin
  set -U fish_user_paths $NPM_PACKAGES/bin $fish_user_paths
end


# # Android tools
# set -gx ANDROID_PATH $HOME/android-sdk-macosx
# if test -e $ANDROID_PATH
#   set -U fish_user_paths $ANDROID_PATH/tools $fish_user_paths
#   set -U fish_user_paths $ANDROID_PATH/platform-tools $fish_user_paths
# end



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



set fish_path $HOME/.oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish


