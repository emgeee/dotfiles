# Commit uncommitted changes with commit message
# push branch to remote origin
# open PR
# args: Git commit message
function gitchensync
  set msg $argv[1..-1]

  set current_branch (git rev-parse --abbrev-ref HEAD)

  if test "$current_branch" = "master"
    echo "Can't open a PR against master branch"
    return 1
  end

  echo "pausing for 3 seconds..."
  sleep 3

  echo "commiting to git"
  git commit -am $msg

  echo "pushing to origin"
  git push -u origin $current_branch

  echo "opening PR"
  set url (hub pull-request -m $msg -e)
  echo "PR URL: $url"
  open $url
end
