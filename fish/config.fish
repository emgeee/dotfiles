### Begin custom fish customization

# Use lsd instead of ls
# brew install lsd
# requires a patched font from https://www.nerdfonts.com/
# configure Iterm>Profile>Non ASCII font
# alias ls='lsd'
alias icat="kitty +kitten icat"

# # prepend ~/.bin/
fish_add_path $HOME/.bin

# add Solana
fish_add_path $HOME/.local/share/solana/install/active_release/bin

# For ARM Mac
if test -e /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

# Universal environment variables
set -Ux HOSTNAME (hostname)
set -Ux EDITOR vim
set -Ux REACT_EDITOR code

if type vimpager >/dev/null 2>&1
  set -Ux PAGER vimpager
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
# Install binaries via pip requires reshiming: asdf reshim python
# Versions of tools specified in ~/.tool-versions file
if test -e /usr/local/opt/asdf/asdf.fish
  source /usr/local/opt/asdf/asdf.fish
end

# For ARM architecture
if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end
#######################
#

####################### go config
# Configure GOROOT and GOPATH
set -Ux GOPATH $HOME/go

fish_add_path $GOPATH/bin
#######################


# current instructions for python: https://opensource.com/article/19/5/python-3-default-mac
# Disable virtual env on the left side of the prompt
# useful if the selected theme has built in support
# set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# set -Ux PYENV_ROOT $HOME/.pyenv
# brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper

# configure virtual env
# status --is-interactive; and source (pyenv init -|psub)

# pyenv virtualenv
# status --is-interactive; and source (pyenv virtualenv-init -|psub)

# default bin for brew Python 3.9
# if test -e $HOME/Library/Python/3.9/bin
#   set PATH $HOME/Library/Python/3.9/bin $PATH
# end

# pip install virtualfish
# vf install
set pipenv_fish_fancy yes

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
