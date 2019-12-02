function git_remove_branch_and_remote() {
	readonly branch=${1:?"You need to provide a branch name to remove together with a remote."}	
	readonly current=$(git rev-parse --abbrev-ref HEAD)

	if [[ "master" == $branch ]] || [[ "develop" == $branch ]]; then
		echo "If you want to remove $branch, do it manually, ok?"
	else
		if [[ $current == $branch ]]; then
			echo "You're on a branch you want to remove. Please checkout any different branch."
		else
			read "response?Remove $branch AND origin/$branch (if it exists)? [y/N] ?"
			if [[ "$response" =~ ^[Yy]$ ]]; then
				git branch -d $branch
				branch_exists_remotely=$(git ls-remote --heads origin $branch)
				if [[ $branch_exists_remotely != "" ]]; then				
					git push --delete origin $branch
				fi
			else
				echo "Ok, didn't do anything now."
			fi
		fi	
	fi
}

function git_cleanup() {
	readonly main_branch=${1:?"You need to provide a branch name that's considered to be the main branch."}	

	git checkout ${main_branch}
	git fetch -p

	for branch in `git branch --merged | egrep -v "(^\*|$main_branch)"`; do
		git_remove_branch_and_remote $branch
	done

	echo "\nThese branches are MERGED on remote. They don't exist locally. //start list"
	for branch in `git branch -r --merged | egrep -v "(^\*|$main_branch|HEAD)"`; do 
		echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\tgit push --delete $branch | sed 's/origin\//origin /'; 
	done | sort -r
	echo "//end list"

	echo "\nThese branches are NOT merged on remote. //start list"
	for branch in `git branch -r --no-merged | egrep -v "(^\*|$main_branch|HEAD)"`; do 
		echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; 
	done | sort -r
	echo "//end list"
}

alias gclean='git_cleanup'
