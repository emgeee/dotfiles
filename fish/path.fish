######################################################################
#                           PATH CONFIGURATION
######################################################################

### 1. Homebrew LAST (lowest priority)
# Force correct position by removing then re-adding
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_NO_ANALYTICS 1

# Remove homebrew paths from wherever they currently are (e.g. /etc/paths.d)
set -l new_path
for p in $PATH
    if not string match -q '/opt/homebrew/*' $p
        set -a new_path $p
    end
end
set -gx PATH $new_path

# Add them at the front (will end up below user paths but above system)
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

set -x GCLOUD_HOME $HOME/google-cloud-sdk/path.fish.inc
if test -z $GCLOUD_HOME
  source $GCLOUD_HOME
end

### 3. User bins (higher priority)
fish_add_path --path $HOME/.cargo/bin
fish_add_path --path $HOME/.local/bin
fish_add_path --path $HOME/.bin

fish_add_path --path $HOME/google-cloud-sdk/bin


