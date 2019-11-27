function git_cleanup() {
	git checkout master
	git fetch -p

	git branch --merged | egrep -v "(^\*|master)" | xargs git push --delete origin
	git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d

	echo "=========================================="
	echo "Remove this manually from remote (merged):"
	for branch in `git branch -r --merged | egrep -v "(^\*|master|HEAD)"`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\tgit push --delete $branch | sed 's/origin\//origin /'; done | sort -r

	echo "=========================================="
	echo "These are NOT merged on remote"
	for branch in `git branch -r --no-merged | egrep -v "(^\*|master|HEAD)"`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r
}

alias gclean='git_cleanup'
