function docker_stop_all_containers() {
  docker ps -q | xargs docker stop
}

alias dockstop=docker_stop_all_containers
