### Begin custom fish customization

source ~/.config/fish/path.fish

# mise (runtime version manager)
mise activate fish | source

# Aliases
alias ls='lsd'
alias icat="kitty +kitten icat"

# Global environment variables
set -gx HOSTNAME (hostname)
set -gx EDITOR vim
set -gx REACT_EDITOR code

if type -q vimpager
    set -gx PAGER vimpager
end

# yabai helpers
if test -e $HOME/.config/yabai/helpers.fish
    source $HOME/.config/yabai/helpers.fish
end

# GCloud\set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True

####################### PYTHON CONFIGURATION ########################
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
set -gx PIP_REQUIRE_VIRTUALENV true

function __auto_activate_venv --on-event fish_prompt --on-variable PWD
    auto_activate_venv
end
######################################################################

# direnv
eval (direnv hook fish)

# ssh + tmux helper
function sshtmux
    set host $argv[1]
    autossh -M 0 $host -t "tmux -CC new-session -A -s $host"
end

# Additional user aliases
if test -e $HOME/.config/fish/aliases.fish
    source $HOME/.config/fish/aliases.fish
end

# Private env
if test -e $HOME/.config/fish/private_environment.fish
    source $HOME/.config/fish/private_environment.fish
end

# Jupyter
set -gx JUPYTER_PLATFORM_DIRS 1

# Tide prompt configuration
set -g tide_right_prompt_items status cmd_duration context jobs direnv node python distrobox
