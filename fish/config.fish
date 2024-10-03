### Begin custom fish customization

# Use lsd instead of ls
# brew install lsd
# requires a patched font from https://www.nerdfonts.com/
# brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
# configure iTerm>Profile>Non ASCII font
# `set -U` stores variables in the fish_variables file.
#
# A note on paths for OSX - the os has a launchctl user PATH entry
# stored in  /private/var/db/com.apple.xpc.launchd/config/user.plist
# You can view it with the command `launchctl getenv PATH`
# https://forums.developer.apple.com/forums/thread/106904

alias ls='lsd'
alias icat="kitty +kitten icat"

# # prepend ~/.bin/
fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# Rye python project/package manager
fish_add_path $HOME/.rye/shims

# For ARM Mac
if test -e /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end
set HOMEBREW_NO_ANALYTICS 1

# Universal environment variables
set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux REACT_EDITOR code

if type vimpager >/dev/null 2>&1
  set -Ux PAGER vimpager
end

####################### OMF config
# Path to Oh My Fish install.
set -Ux OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -Ux OMF_CONFIG "$HOME/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Load yabai helper functions
if test -e $HOME/.config/yabai/helpers.fish
  source $HOME/.config/yabai/helpers.fish
end

# OMF theme - bobthefish: `omf install bobthefish`
#######################

set -gx PNPM_HOME $HOME/Library/pnpm
fish_add_path $PNPM_HOME

####################### asdf configuration
# installed via homebrew
# Install binaries via pip requires reshiming: asdf reshim python
# Versions of tools specified in ~/.tool-versions file
if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end


if test -e $HOME/.asdf/plugins/java/set-java-home.fish
  . $HOME/.asdf/plugins/java/set-java-home.fish
end

#######################

####################### go config
# Configure GOROOT and GOPATH
set -gx GOPATH $HOME/go

fish_add_path $GOPATH/bin
#######################

#
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True


#######################
# python configuration

# current instructions for python: https://opensource.com/article/19/5/python-3-default-mac
# Disable virtual env on the left side of the prompt
# useful if the selected theme has built in support
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# Require a virtual env to be activated to pip install
set -gx PIP_REQUIRE_VIRTUALENV true

# activate the venv if a new session is started or the PWD changes
function __auto_activate_venv --on-event fish_prompt --on-variable PWD --description "Auto activate/deactivate virtualenv when I change directories"
    auto_activate_venv
end
#######################


function sshtmux
  set host $argv[1]
  autossh -M 0 $host -t "tmux -CC new-session -A -s $host"
end

if test -e $HOME/.config/fish/aliases.fish
  source $HOME/.config/fish/aliases.fish
end

if test -e $HOME/.config/fish/private_environment.fish
  source $HOME/.config/fish/private_environment.fish
end

test -e $HOME/.iterm2_shell_integration.fish ; and source $HOME/.iterm2_shell_integration.fish

# Use new paths for jupyter notebooks
set -Ux JUPYTER_PLATFORM_DIRS 1

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin
