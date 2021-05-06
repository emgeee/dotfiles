# Launch a single instance of the gopls server
# disown allows the server to continue running after the fish shell is closed
function start-gopls
  killall gopls;
  rm /tmp/gopls-daemon-socket ; $GOPATH/bin/gopls -listen="unix;/tmp/gopls-daemon-socket" -logfile=auto serve --debug=localhost:6060 & disown
end

