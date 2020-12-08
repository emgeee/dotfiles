### Begin custom fish customization

# # prepend ~/.bin/
if test -e $HOME/.bin
  set PATH $HOME/.bin $PATH
end

# Universal environment variables
set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux REACT_EDITOR code

if type vimpager >/dev/null 2>&1
  set -Ux PAGER vimpager
end

# set -x ANDROID_HOME $HOME/Library/Android/sdk
# set -x JAVA_HOME (/usr/libexec/java_home)

# Add android tools to path
if test -e $ANDROID_HOME
  set -U PATH $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $PATH
end

####################### OMF config
# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG "$HOME/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# OMF theme - bobthefish: `omf install bobthefish`
#######################


####################### asdf configuration
# installed via homebrew
if test -e /usr/local/opt/asdf/asdf.fish
  source /usr/local/opt/asdf/asdf.fish
end
#######################
#

####################### go config
# Configure GOROOT and GOPATH
set -Ux GOPATH $HOME/go

if test -e $GOPATH/bin
  set PATH $GOPATH/bin $PATH
end
#######################


# Disable virtual env on the left side of the prompt
# useful if the selected theme has built in support
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

set -Ux PYENV_ROOT $HOME/.pyenv
# brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper
# configure virtual env
# status --is-interactive; and source (pyenv init -|psub)
# pyenv virtualenv
# status --is-interactive; and source (pyenv virtualenv-init -|psub)

# pip install virtualfish
# vf install

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
