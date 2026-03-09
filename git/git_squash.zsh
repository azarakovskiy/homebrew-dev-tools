# shellcheck shell=zsh

function git_squash_two_commits() {
  local commit_count

  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Working tree must be clean before squashing."
    return 1
  fi

  commit_count="$(git rev-list --count HEAD 2>/dev/null || echo 0)"
  if (( commit_count < 2 )); then
    echo "Need at least two commits to squash."
    return 1
  fi

  git reset --soft HEAD^ && git commit --amend
}

alias gsquash='git_squash_two_commits'
