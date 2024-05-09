# Commit uncommitted changes with commit message
# push branch to remote origin
# open PR
# args: Git commit message
function gitchensync
  set msg $argv[1..-1]

  set current_branch (git rev-parse --abbrev-ref HEAD)

  if test "$current_branch" = "main"
    echo "Can't open a PR current branch is main"
    return 1
  end

  # If the default repo is not set, prompt user to set it before continuing
  gh repo set-default

  echo "pausing for 3 seconds..."
  sleep 3

  echo "committing to git"
  git commit -am $msg

  echo "pushing to origin"
  git push -u origin $current_branch

  echo "opening PR"
  gh pr create --base main
  gh pr view --web
end
