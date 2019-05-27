function git_rebase_onto_master() {
    git checkout master
    git pull
    git checkout -
    git rebase master
}

function git_pr() {
    export PREFIX="""PR-"""
    export PR_NUMBER=$1
    export BRANCH_NAME="""${PREFIX}${PR_NUMBER}"""
    git checkout master
    git rev-parse --verify ${BRANCH_NAME}
    if [[ $? == 0 ]]; then
        git branch -D ${BRANCH_NAME}
    fi
    git fetch origin pull/${PR_NUMBER}/head:${BRANCH_NAME}
    git checkout ${BRANCH_NAME}
}

# Rebase current branch onto master
alias grb=git_rebase_onto_master

# Checkout PR as a branch or update existing
alias gpr=git_pr
