#!/bin/bash
set -euo pipefail

# $1: registry image version, defaults to 'latest'
# $2: target registry
# $3: port

CONTAINER_NAME="registry_$3"

start() {
	podman start ${CONTAINER_NAME}
	echo "Registry started."
}

unpause() {
	podman unpause ${CONTAINER_NAME}
	echo "Registry unpaused."
}

noop() {
	echo "Already running." >&2
}

# podman exec -it registry /bin/sh
# vi /etc/docker/registry/config.yml 

# $1: registry image version, defaults to 'latest'
# $2: name
# $3: port
# ${CONTAINER_NAME}

create() {
	SRC="./registry_$3"
	DEST='/etc/docker/registry'
	podman run -d -p "$3:5000" -v ${SRC}:${DEST} \
		--http-proxy=false --name ${CONTAINER_NAME} \
		registry:$1
	echo "Registry created."
}

JQ_PROGRAM=".[] | select(.Names[] == \"${CONTAINER_NAME}\") | .State"
STATUS=$(podman ps --all --format=json | jq -r "${JQ_PROGRAM}")

#if [ "xx" == "x${STATUS}x" ]; then
#	create $1 x $3
#else
	case ${STATUS} in
		created | exited)
			start
			;;
		paused)
			unpause
			;;
		running)
			noop
			;;
		*)
			create $1 x $3
			;;
	esac
#fi
