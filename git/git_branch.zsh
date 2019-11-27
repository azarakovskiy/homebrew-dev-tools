function git_branch_checkout() {
    BRANCH_NAME=$1
    git rev-parse --verify ${BRANCH_NAME} &> /dev/null

    if [[ $? == 0 ]]; then
        git checkout ${BRANCH_NAME}
        if [[ $? == 0 ]]; then
            echo "Checked out existing branch"
        fi
    else 
        git checkout -b ${BRANCH_NAME}
        if [[ $? == 0 ]]; then
            echo "Created and checked out a new branch"
        fi
    fi
}

# Checkout a branch or create a new one
alias gbranch=git_branch_checkout
