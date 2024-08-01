#!/bin/bash
set -euo pipefail

start() {
	podman start registry
}

unpause() {
	podman unpause registry
}

noop() {
	echo "Already running."
}

# podman exec -it registry /bin/sh
# vi /etc/docker/registry/config.yml 

create() {
	SRC='./registry'
	DEST='/etc/docker/registry'
	PORTS='5000:5000'
	podman run -d -p ${PORTS} -v ${SRC}:${DEST} --http-proxy=false \
		--name registry registry:$1
}

JQ_PROGRAM=".[] | select(.Names[] == \"registry\") | .State"
STATUS=$(podman ps --all --format=json | jq -r "${JQ_PROGRAM}")

#if [ "xx" == "x${STATUS}x" ]; then
#	create
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
			create $1
			;;
	esac
#fi
