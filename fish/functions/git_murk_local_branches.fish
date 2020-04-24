
# Force delete local branches
function git_murk_local_branches
  echo 'Run the following command: DANGEROUS!'
  echo 'git branch -l | egrep -v "(^\*|master|dev)" | xargs git branch -D'
end
