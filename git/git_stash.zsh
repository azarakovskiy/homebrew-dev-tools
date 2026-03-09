# shellcheck shell=zsh

function git_stash_save_name() {
  local stash_name="${1:?You need to provide a name for a stash.}"
  git stash push -m "$stash_name"
}

function git_stash_find_name_ref() {
  local stash_name="${1:?You need to provide a stash name.}"
  git stash list | awk -v name="$stash_name" -F: 'index($0, name) {print $1; exit}'
}

function git_stash_apply_name() {
  local stash_name="${1:?You need to provide a name for a stash.}"
  local stash_ref

  stash_ref="$(git_stash_find_name_ref "$stash_name")"
  if [[ -z "$stash_ref" ]]; then
    echo "No stash found with name containing '$stash_name'."
    return 1
  fi

  git stash apply "$stash_ref" && git stash drop "$stash_ref"
}

function git_stash_name() {
  local action="${1:?You need to provide an action as first param: push or pop.}"
  local stash_name="${2:-}"

  case "$action" in
    push)
      if [[ -z "$stash_name" ]]; then
        git stash
      else
        git_stash_save_name "$stash_name"
      fi
      ;;
    pop)
      if [[ -z "$stash_name" ]]; then
        git stash pop
      else
        git_stash_apply_name "$stash_name"
      fi
      ;;
    *)
      echo "Syntax: gstash push [NAME] | gstash pop [NAME]"
      return 1
      ;;
  esac
}

alias gstash=git_stash_name
