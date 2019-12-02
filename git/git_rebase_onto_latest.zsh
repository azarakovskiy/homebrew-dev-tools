function git_rebase_onto_latest() {
	readonly target=${1:?"You need to provide a branch name to rebase current onto."}	
    git diff-index --quiet HEAD -- 
    if [[ $? == 1 ]]; then
        echo "There are some changes in a working tree. First you need to have it clean."
        echo "Stash them:\n\tgstash push\n\t< do a rebase here >\n\tgstash pop"
        echo "Or commit them:\n\tgcommit\n\t< do a rebase here >"
    else
        git checkout ${target}
        git pull --rebase
        git checkout -
        git rebase -i ${target}
    fi    
}

# Rebase current branch onto latest state of a given branch
alias grebase=git_rebase_onto_latest
