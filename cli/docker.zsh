# shellcheck shell=zsh

function docker_stop_all_containers() {
  emulate -L zsh

  if ! command -v docker >/dev/null 2>&1; then
    echo "docker is not installed." >&2
    return 1
  fi

  local -a container_ids
  container_ids=("${(@f)$(docker ps -q)}")

  if (( ${#container_ids[@]} == 0 )); then
    echo "No running containers."
    return 0
  fi

  docker stop "${container_ids[@]}"
}

function docker_prune_volumes() {
  emulate -L zsh

  local container_id="${1:?Container ID is required.}"
  local volume_output
  local -a volumes

  if ! command -v docker >/dev/null 2>&1; then
    echo "docker is not installed." >&2
    return 1
  fi

  if ! docker inspect "$container_id" >/dev/null 2>&1; then
    echo "Container '$container_id' does not exist."
    return 1
  fi

  volume_output="$(docker inspect --format '{{ range .Mounts }}{{ if .Name }}{{ .Name }} {{ end }}{{ end }}' "$container_id")"
  volumes=("${(@s: :)volume_output}")
  typeset -U volumes

  docker stop "$container_id" >/dev/null 2>&1 || true
  docker rm "$container_id"
  echo "Container '$container_id' has been removed."

  if (( ${#volumes[@]} > 0 )); then
    docker volume rm "${volumes[@]}"
    echo "Removed associated named volumes."
  else
    echo "No associated named volumes to remove."
  fi
}

alias dockstop=docker_stop_all_containers
alias dockrmvol=docker_prune_volumes
