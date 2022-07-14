
# When using kitty terminal editor, pass supported terminal features to remove server
# Also possible to set TERM=xterm-256color before `ssh`ing
function kssh
  kitty +kitten ssh $argv[1..-1]
end
