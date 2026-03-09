# shellcheck shell=zsh

function _use_go_resolve_goroot() {
  emulate -L zsh

  local requested_version="${1:?Go version is required.}"
  local formula
  local prefix

  if ! command -v brew >/dev/null 2>&1; then
    return 1
  fi

  if [[ "$requested_version" == "latest" ]]; then
    formula="go"
  else
    formula="go@${requested_version}"
  fi

  prefix="$(brew --prefix "$formula" 2>/dev/null || true)"
  if [[ -z "$prefix" || ! -d "$prefix/libexec" ]]; then
    return 1
  fi

  echo "$prefix/libexec"
}

function _use_go_version() {
  emulate -L zsh

  local requested_version="${1:?Go version is required.}"
  local goroot

  goroot="$(_use_go_resolve_goroot "$requested_version")" || {
    echo "Go version '$requested_version' is not installed via Homebrew."
    if [[ "$requested_version" == "latest" ]]; then
      echo "Install with: brew install go"
    else
      echo "Install with: brew install go@${requested_version}"
    fi
    return 1
  }

  export GOROOT="$goroot"

  if [[ ":$PATH:" != *":$GOROOT/bin:"* ]]; then
    export PATH="$GOROOT/bin:$PATH"
  fi

  hash -r
  go version
  echo "GOROOT set to $GOROOT"
}

function useFn() {
  emulate -L zsh

  local tool_name="${1:?Specify tool name.}"
  local version="${2:?Specify tool version.}"

  case "$tool_name" in
    go)
      _use_go_version "$version"
      ;;
    *)
      echo "Unsupported tool '$tool_name'. Currently supported: go"
      return 1
      ;;
  esac
}

alias use=useFn
