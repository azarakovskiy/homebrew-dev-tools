function git_squash_two_commits() {
	git reset --soft "HEAD^" && git commit --amend
}

alias gsquash='git_squash_two_commits'
