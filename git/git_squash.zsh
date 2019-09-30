function git_squash() {
	git reset --soft "HEAD^" && git commit --amend
}

alias gitsq='git_squash'