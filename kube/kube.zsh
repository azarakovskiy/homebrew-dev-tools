# shellcheck shell=zsh

if command -v kubectl >/dev/null 2>&1; then
  if whence compdef >/dev/null 2>&1; then
    source <(kubectl completion zsh)
  fi
else
  echo "[devtools][warn] kubectl not found. kube aliases are limited." >&2
fi

alias k='kubectl'

function kube_context() {
  emulate -L zsh

  local action="${1:-list}"
  local context_name

  case "$action" in
    list)
      k config get-contexts
      ;;
    use)
      context_name="${2:?Context name is required: kctx use <context>}"
      k config use-context "$context_name"
      ;;
    set-template)
      echo 'Template: kubectl config set-context CONTEXT --cluster=CLUSTER --user=USER'
      ;;
    *)
      echo "Usage: kctx [list|use <context>|set-template]"
      return 1
      ;;
  esac
}

function kube_pods() {
  emulate -L zsh

  local action="${1:-list}"
  local pod_name

  case "$action" in
    list)
      k get pods
      ;;
    exec)
      pod_name="${2:?Pod name is required: kpods exec <pod> <command...>}"
      shift 2
      if (( $# == 0 )); then
        echo "Command is required: kpods exec <pod> <command...>"
        return 1
      fi
      k exec -it "$pod_name" -- "$@"
      ;;
    del)
      pod_name="${2:?Pod name is required: kpods del <pod>}"
      k delete pod "$pod_name"
      ;;
    logs)
      pod_name="${2:?Pod name is required: kpods logs <pod>}"
      k logs -f "$pod_name"
      ;;
    desc)
      pod_name="${2:?Pod name is required: kpods desc <pod>}"
      k describe pod "$pod_name"
      ;;
    *)
      echo "Usage: kpods [list|exec <pod> <command...>|del <pod>|logs <pod>|desc <pod>]"
      return 1
      ;;
  esac
}

function kube_namespaces() {
  k get namespaces
}

alias kctx='kube_context'
alias kpods='kube_pods'
alias kns='kube_namespaces'
