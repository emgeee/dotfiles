
# Checks if there's a merge conflict with a different branch
function git-check-merge-conflicts
  echo Checking for merge conflicts with branch $argv[1]

  git merge --no-commit --no-ff $argv[1]
  echo $status
  git merge --abort
end
