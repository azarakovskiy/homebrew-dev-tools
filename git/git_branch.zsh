# shellcheck shell=zsh

function git_branch_verify_and_checkout() {
  local branch_name="${1:?Branch name is required.}"

  if git show-ref --verify --quiet "refs/heads/$branch_name"; then
    git switch "$branch_name" 2>/dev/null || git checkout "$branch_name"
    echo "Checked out existing branch '$branch_name'."
  else
    git switch -c "$branch_name" 2>/dev/null || git checkout -b "$branch_name"
    echo "Created and checked out branch '$branch_name'."
  fi
}

function git_branch_checkout() {
  local branch_name="${1:-}"

  if [[ -z "$branch_name" || "$branch_name" == "-" ]]; then
    git switch - 2>/dev/null || git checkout -
    echo "Checked out previous branch."
    return
  fi

  git_branch_verify_and_checkout "$branch_name"
}

alias gbranch=git_branch_checkout
