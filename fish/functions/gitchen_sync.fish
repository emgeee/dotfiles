# Commit uncommitted changes with commit message
# push branch to remote origin
# open PR
# args: Git commit message
function gitchen_sync
  set msg $argv[1..-1]
  echo "pausing for 3 seconds..."
  sleep 3

  echo "commiting to git"
  git commit -am $msg

  echo "pushing to origin"
  git push -u origin (git rev-parse --abbrev-ref HEAD)

  echo "opening PR"
  set url (hub pull-request -m $msg)
  echo "PR URL: $url"
  open $url
end
