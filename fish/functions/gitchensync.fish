# Commit uncommitted changes with commit message
# push branch to remote origin
# open PR
# args: Git commit message
function gitchensync
    set msg $argv[1..-1]

    # Get current branch
    set current_branch (git rev-parse --abbrev-ref HEAD)

    # Get repo's default branch from GitHub
    set default_branch (gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')

    # Prevent PRs from protected branches
    if test "$current_branch" = "$default_branch"
        echo "Can't open a PR: current branch is $current_branch"
        return 1
    end

    # Ensure a default GitHub repo is configured
    gh repo set-default

    echo "pausing for 3 seconds..."
    sleep 3

    echo "committing to git"
    git commit -am "$msg"

    echo "pushing to origin"
    git push -u origin "$current_branch"

    echo "opening PR"
    gh pr create --base "$default_branch" --title "$msg"
    gh pr view --web
end
