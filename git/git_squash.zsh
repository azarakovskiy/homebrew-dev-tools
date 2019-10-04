function git_squash() {
	git reset --soft "HEAD^" && git commit --amend
}

alias gsq='git_squash'