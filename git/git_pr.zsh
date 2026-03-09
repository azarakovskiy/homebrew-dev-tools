# shellcheck shell=zsh

function git_pr() {
  local pr_number="${1:?PR number is required.}"

  if [[ ! "$pr_number" =~ ^[0-9]+$ ]]; then
    echo "PR number must be numeric."
    return 1
  fi

  local branch_name="PR-$pr_number"

  if ! git fetch origin "pull/${pr_number}/head"; then
    echo "Failed to fetch PR #$pr_number from origin."
    return 1
  fi

  git checkout -B "$branch_name" FETCH_HEAD
}

alias gpr=git_pr
