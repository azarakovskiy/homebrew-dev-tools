function git_rebase_onto_latest() {
	readonly target=${1:?"You need to provide a branch name to rebase current onto."}

	git stash
    git checkout ${target}
    git pull --rebase
    git checkout -
    git rebase -i ${target}
    git stash pop
}

# Rebase current branch onto latest state of a given branch
alias grebase=git_rebase_onto_latest
