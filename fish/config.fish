### Begin custom fish customization

# PATH
set -e fish_user_paths

# # prepend ~/.bin/
if test -e $HOME/.bin
  set -U fish_user_paths $HOME/.bin $PATH
end

# Universal environment variables
set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux REACT_EDITOR code

if type vimpager >/dev/null 2>&1
  set -Ux PAGER vimpager
end

set -x NODE_ENV local
set -x ANDROID_HOME /usr/local/opt/android-sdk
set -x JAVA_HOME (/usr/libexec/java_home)

if test -e $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -e $HOME/.config/fish/private_environment.fish
  source $HOME/.config/fish/private_environment.fish
end

# if not contains /usr/local/share/npm/bin $PATH
#   set PATH /usr/local/share/npm/bin $PATH
# end
#
if not contains ./node_modules/.bin $PATH
  set PATH ./node_modules/.bin $PATH
end


## OMF config
# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/matt/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/matt/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
