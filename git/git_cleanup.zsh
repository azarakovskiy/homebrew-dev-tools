# shellcheck shell=zsh

function _cleanup_default_base_branch() {
  if git show-ref --verify --quiet refs/heads/main; then
    echo "main"
  elif git show-ref --verify --quiet refs/heads/master; then
    echo "master"
  else
    echo ""
  fi
}

function _cleanup_branch_is_merged() {
  local branch_name="${1:?Branch name is required.}"
  local base_branch="${2:?Base branch is required.}"

  git merge-base --is-ancestor "$branch_name" "$base_branch" >/dev/null 2>&1
}

function cleanup_my_branches() {
  emulate -L zsh

  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Not inside a git repository."
    return 1
  fi

  local default_base base_branch ticket_filter current_branch
  local delete_all delete_remote
  local -a all_branches candidate_branches failed_branches

  default_base="$(_cleanup_default_base_branch)"
  if [[ -n "${1:-}" ]]; then
    base_branch="$1"
  else
    read "base_branch?Enter base branch [${default_base}]: "
    base_branch="${base_branch:-$default_base}"
  fi

  if [[ -z "$base_branch" ]] || ! git show-ref --verify --quiet "refs/heads/$base_branch"; then
    echo "Base branch '$base_branch' does not exist locally."
    return 1
  fi

  ticket_filter="${2:-}"
  if [[ -z "$ticket_filter" ]]; then
    read "ticket_filter?Optional ticket filter (leave empty for all): "
  fi

  current_branch="$(git branch --show-current 2>/dev/null || true)"

  echo "Fetching latest changes from origin..."
  git fetch origin --quiet >/dev/null 2>&1 || echo "Warning: could not fetch origin"

  all_branches=("${(@f)$(git for-each-ref --format='%(refname:short)' refs/heads)}")
  candidate_branches=()

  local branch
  for branch in "${all_branches[@]}"; do
    [[ -z "$branch" ]] && continue
    [[ "$branch" == "$base_branch" ]] && continue
    [[ "$branch" == "$current_branch" ]] && continue
    [[ "$branch" == "main" || "$branch" == "master" ]] && continue
    [[ -n "$ticket_filter" && "$branch" != *"$ticket_filter"* ]] && continue

    if _cleanup_branch_is_merged "$branch" "$base_branch"; then
      candidate_branches+=("$branch")
    fi
  done

  if (( ${#candidate_branches[@]} == 0 )); then
    echo "No merged local branches eligible for cleanup."
    return 0
  fi

  echo "Eligible branches (${#candidate_branches[@]}):"
  printf '  - %s\n' "${candidate_branches[@]}"

  read "delete_all?Delete all these local branches? (y/n): "
  if [[ ! "$delete_all" =~ '^[Yy]$' ]]; then
    echo "Cancelled."
    return 0
  fi

  read "delete_remote?Also delete matching remote branches from origin? (y/n): "

  failed_branches=()
  for branch in "${candidate_branches[@]}"; do
    if git branch -d "$branch"; then
      if [[ "$delete_remote" =~ '^[Yy]$' ]] && git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
        git push origin --delete "$branch" >/dev/null 2>&1 || echo "Warning: failed to delete remote branch origin/$branch"
      fi
    else
      failed_branches+=("$branch")
    fi
  done

  if (( ${#failed_branches[@]} > 0 )); then
    echo "Failed to delete:"
    printf '  - %s\n' "${failed_branches[@]}"
    return 1
  fi

  echo "Cleanup finished successfully."
}

alias cleanup='cleanup_my_branches'
alias gclean='cleanup_my_branches'
