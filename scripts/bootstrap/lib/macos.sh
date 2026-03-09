#!/usr/bin/env bash

set -euo pipefail

bootstrap_apply_macos_global_float() {
  local key="$1"
  local target_value="$2"
  local current_value

  current_value="$(defaults read -g "$key" 2>/dev/null || true)"
  if [[ "$current_value" == "$target_value" ]]; then
    bootstrap_log "macOS default already set: $key=$target_value"
    return 0
  fi

  bootstrap_run_cmd defaults write -g "$key" -float "$target_value"
}

bootstrap_apply_macos_current_host_int() {
  local key="$1"
  local target_value="$2"
  local current_value

  current_value="$(defaults -currentHost read -g "$key" 2>/dev/null || true)"
  if [[ "$current_value" == "$target_value" ]]; then
    bootstrap_log "macOS currentHost default already set: $key=$target_value"
    return 0
  fi

  bootstrap_run_cmd defaults -currentHost write -g "$key" -int "$target_value"
}

bootstrap_apply_macos_settings() {
  bootstrap_log "Applying one-time macOS settings"

  # Previously configured from shell runtime; now applied in bootstrap only.
  bootstrap_apply_macos_global_float "com.apple.mouse.scaling" "9.0"

  # Preserved from legacy installer.
  bootstrap_apply_macos_current_host_int "AppleFontSmoothing" "0"
}
