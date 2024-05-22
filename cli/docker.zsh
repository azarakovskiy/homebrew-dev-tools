function docker_stop_all_containers() {
  docker ps -q | xargs docker stop
}

function docker_prune_volumes() {
    local container_id="$1"

    # Check if container ID is provided
    if [ -z "$container_id" ]; then
        echo "Container ID is missing."
        return 1
    fi

    # Check if container exists
    if ! docker inspect "$container_id" >/dev/null 2>&1; then
        echo "Container $container_id does not exist."
        return 1
    fi

    # List associated volumes
    volumes=$(docker inspect --format '{{ range .Mounts }}{{ if .Name }}{{ .Name }} {{ end }}{{ end }}' "$container_id")

    docker stop "$container_id"
    docker rm "$container_id"
    echo "Container $container_id has been removed."

    # Remove associated volumes
    for volume in $volumes; do
        docker volume rm "$volume"
    done

    echo "Volumes associated with container $container_id have been removed."
}

alias dockstop=docker_stop_all_containers
alias dockrmvol=docker_prune_volumes
