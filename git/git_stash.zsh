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

# Git stash with a name
alias gstash=git_stash_name
