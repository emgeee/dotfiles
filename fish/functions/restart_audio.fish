function restart_audio
  sudo kill -9 (ps ax|grep 'coreaudio[a-z]' | awk '{print $1}')
end
