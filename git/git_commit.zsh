function git_commit_all_changes() {
	git add . && git commit
}

alias gcommit='git_commit_all_changes'
