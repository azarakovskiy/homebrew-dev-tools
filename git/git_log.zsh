# shellcheck shell=zsh

function git_log_release_notes() {
  local last_tag
  last_tag="$(git describe --tags --abbrev=0 2>/dev/null || true)"

  if [[ -n "$last_tag" ]]; then
    git log "$last_tag"..HEAD -i -E --grep='^.*#[0-9]+.*$' --pretty=format:'* %b%n'
  else
    git log HEAD -i -E --grep='^.*#[0-9]+.*$' --pretty=format:'* %b%n'
  fi
}

function _gloggy() {
  local action="${1:?You must specify an action. Supported: gloggy release}"

  case "$action" in
    release)
      git_log_release_notes
      ;;
    *)
      echo "Supported: gloggy release"
      return 1
      ;;
  esac
}

alias gloggy=_gloggy
