######################################################################
#                           PATH CONFIGURATION
######################################################################

### 1. Homebrew LAST (lowest priority)
# These go first so later prepends will stack *above* them.
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_ANALYTICS 1

fish_add_path --path /opt/homebrew/sbin
fish_add_path --path /opt/homebrew/bin

set -gx MANPATH $HOMEBREW_PREFIX/share/man $MANPATH
set -gx INFOPATH $HOMEBREW_PREFIX/share/info $INFOPATH


### 2. Tool managers and language runtimes (middle priority)

# bun
set -x BUN_INSTALL "$HOME/.bun"
fish_add_path --path $BUN_INSTALL/bin

# go
set -x GOPATH $HOME/go
fish_add_path --path $GOPATH/bin

# pnpm
set -x PNPM_HOME $HOME/Library/pnpm
fish_add_path --path $PNPM_HOME

source $HOME/google-cloud-sdk/path.fish.inc

### 3. User bins (higher priority)
fish_add_path --path $HOME/.cargo/bin
fish_add_path --path $HOME/.local/bin
fish_add_path --path $HOME/.bin


### 4. ASDF shims FIRST (highest priority)
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
