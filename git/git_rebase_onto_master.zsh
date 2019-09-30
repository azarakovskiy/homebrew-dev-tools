function git_rebase_onto_master() {
    git checkout master
    git pull
    git checkout -
    git rebase master
}

# Rebase current branch onto master
alias grb=git_rebase_onto_master