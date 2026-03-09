# shellcheck shell=zsh

function git_commit_all_changes() {
  git add --all && git commit "$@"
}

alias gcommit='git_commit_all_changes'
