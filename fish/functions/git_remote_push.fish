
# push current branch to remote a new remote branch
function git_remote_push
  git push -u origin (git rev-parse --abbrev-ref HEAD)
end
