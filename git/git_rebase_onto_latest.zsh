function git_stash_save_name() {
	readonly name=${1:?"You need to provide a name for a stash."}

    git stash push -m $name
}

function git_stash_apply_name() {
	readonly name=${1:?"You need to provide a name for a stash."}
	readonly st=$(git stash list | grep $name | cut -d: -f1)

    git stash apply $st
    git stash drop $st
}

function git_stash_name() {
	readonly action=${1:?"You need to provide an action as a first param: push or pop."}
	readonly name=${2}

	if [[ $action == "push" ]]; then
		if [[ $name == "" ]]; then
			git stash
		else
			git_stash_save_name $name
		fi
	elif [[ $action = "pop" ]]; then
		if [[ $name == "" ]]; then
			git stash pop
		else
			git_stash_apply_name $name
		fi
	else
		echo "Not sure what to do. Syntax: \n\t gtash push [NAME] \n\t gstash pop [NAME]"
	fi
}

function git_rebase_onto_latest() {
	readonly target=${1:?"You need to provide a branch name to rebase current onto."}	
	readonly epoch=$(date +%s)

	git_stash_name push "git_rebase_onto_latest_$epoch"
    git checkout ${target}
    git pull --rebase
    git checkout -
    git rebase -i ${target}
    git_stash_name pop "git_rebase_onto_latest_$epoch"
}

# Rebase current branch onto latest state of a given branch
alias grebase=git_rebase_onto_latest

# Git stash with a name
alias gstash=git_stash_name
