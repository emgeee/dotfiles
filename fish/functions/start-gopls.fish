# Launch a single instance of the gopls server
# disown allows the server to continue running after the fish shell is closed
function start-gopls
  rm /tmp/gopls-daemon-socket ; $GOPATH/bin/gopls -listen="unix;/tmp/gopls-daemon-socket" -logfile=auto & disown
end

