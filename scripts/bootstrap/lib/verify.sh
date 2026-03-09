#!/usr/bin/env bash

set -euo pipefail

bootstrap_verify_line_present() {
  local line="$1"
  local file="$2"

  if [[ -f "$file" ]] && grep -Fqx "$line" "$file"; then
    printf 'PASS  %s contains expected line\n' "$file"
  else
    printf 'WARN  %s missing expected line: %s\n' "$file" "$line"
  fi
}

bootstrap_verify_command() {
  local command_name="$1"

  if command -v "$command_name" >/dev/null 2>&1; then
    printf 'PASS  command available: %s (%s)\n' "$command_name" "$(command -v "$command_name")"
  else
    printf 'WARN  command missing: %s\n' "$command_name"
  fi
}

bootstrap_run_verify() {
  local brew_bin source_line

  bootstrap_log "Running verification"
  brew_bin="$(bootstrap_find_brew_bin || true)"

  if [[ -n "$brew_bin" ]]; then
    printf 'PASS  Homebrew found at %s\n' "$brew_bin"
  else
    printf 'WARN  Homebrew not found\n'
  fi

  printf -v source_line 'source "%s/all.zsh"' "$BOOTSTRAP_REPO_ROOT"
  bootstrap_verify_line_present "$source_line" "$HOME/.zshrc"

  bootstrap_verify_command git
  bootstrap_verify_command zsh
  bootstrap_verify_command gpg
  bootstrap_verify_command blueutil
  bootstrap_verify_command kubectl
}
