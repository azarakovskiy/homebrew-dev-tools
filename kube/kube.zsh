# k8s tricks
source <(kubectl completion zsh)
alias k='kubectl'

function kube_context() {
	readonly action=$1
	if [[ $action == "" ]]; then
		k config get-contexts
		echo "You wanted to list contexts. Here you are."
	elif [[ $action == "use" ]]; then
		readonly context=${2:?"The kube context must be specified as a 2nd param"}
		k config use-context "$context"
		echo "You wanted to switch a context. Did my best."
	elif [[ $action == "set" ]]; then
		echo "Nothing happened (not implemented yet)..."
		echo "Here is you command template though:\n\n"
		echo "\tk config set-context CONTEXT --cluster=CLUSTER --user=USER"
	else 
		echo "It is not clear what you want. Use \`kctx [VERB CONTEXT]\`"
	fi
}

function kube_pods() {
	readonly action=$1
	if [[ $action == "" ]]; then
		k get pods
		echo "You wanted to list pods. Here you are."
	else 
		readonly podname=${2:?"The kube pod name must be specified as a 2nd param"}
		if [[ $action == "exec" ]]; then
			readonly execCmd=${3:?"The command to execute must be specified as a 3rd param"}
			k exec -it $podname $execCmd
			echo "You wanted to execute a command. Done."
		elif [[ $action == "del" ]]; then
			k delete pods $podname
			echo "You wanted to delete a pod. Bye-bye pod!"
		elif [[ $action == "logs" ]]; then
			k logs -f $podname
			echo "You wanted to check logs of a pod. Happy now?"
		elif [[ $action == "desc" ]]; then
			k describe pods $podname
			echo "You wanted to learn a pod. Is it clear now?"
		else 
			echo "It is not clear what you want. Use \`kpods [VERB PODNAME [EXEC_CMD]]\`"
		fi
	fi
	
}

function kube_namespaces() {
	k get namespaces
}

alias kctx=kube_context
alias kpods=kube_pods