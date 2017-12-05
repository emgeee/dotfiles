
# From https://gist.github.com/dergachev/8259104
function ssh_remote_copy
  echo "Listening for copy data on port 10888"
  while true
    echo "Waiting..." ;
    nc -l -p 10888 | pbcopy;
    echo "Copied...";
  end
end
