#!/usr/bin/env bash

set -euo pipefail

: "${BOOTSTRAP_REPO_ROOT:?BOOTSTRAP_REPO_ROOT is required}"
: "${BOOTSTRAP_DRY_RUN:=0}"

bootstrap_log() {
  printf '[bootstrap] %s\n' "$*"
}

bootstrap_warn() {
  printf '[bootstrap][warn] %s\n' "$*" >&2
}

bootstrap_die() {
  printf '[bootstrap][error] %s\n' "$*" >&2
  exit 1
}

bootstrap_print_cmd() {
  printf '%q ' "$@"
  printf '\n'
}

bootstrap_run_cmd() {
  if (( BOOTSTRAP_DRY_RUN )); then
    printf '[dry-run] '
    bootstrap_print_cmd "$@"
    return 0
  fi

  "$@"
}

bootstrap_append_line_once() {
  local line="$1"
  local file="$2"

  if [[ -f "$file" ]] && grep -Fqx "$line" "$file"; then
    return 0
  fi

  if (( BOOTSTRAP_DRY_RUN )); then
    printf '[dry-run] append to %q: %s\n' "$file" "$line"
    return 0
  fi

  mkdir -p "$(dirname "$file")"
  touch "$file"
  printf '\n%s\n' "$line" >> "$file"
}

bootstrap_find_brew_bin() {
  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    printf '/opt/homebrew/bin/brew\n'
    return 0
  fi

  if [[ -x "/usr/local/bin/brew" ]]; then
    printf '/usr/local/bin/brew\n'
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return 0
  fi

  return 1
}

bootstrap_expected_brew_bin_for_arch() {
  if [[ "$(uname -m)" == "arm64" ]]; then
    printf '/opt/homebrew/bin/brew\n'
  else
    printf '/usr/local/bin/brew\n'
  fi
}

bootstrap_resolve_brew_bin() {
  local brew_bin

  if brew_bin="$(bootstrap_find_brew_bin)"; then
    printf '%s\n' "$brew_bin"
    return 0
  fi

  if (( BOOTSTRAP_DRY_RUN )); then
    brew_bin="$(bootstrap_expected_brew_bin_for_arch)"
    bootstrap_warn "Homebrew not installed yet; assuming future path: $brew_bin"
    printf '%s\n' "$brew_bin"
    return 0
  fi

  bootstrap_die "Homebrew binary not found after install step."
}
