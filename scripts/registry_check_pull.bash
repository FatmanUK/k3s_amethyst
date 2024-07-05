#!/bin/bash
set -uxo pipefail

#CACHE_LIST_URL='http://localhost:5000/v2/_catalog'
#CACHE_LIST=$(curl --no-progress-meter ${CACHE_LIST_URL})

for IMAGE in $@; do
	# remove domain from IMAGE
	IMG=$(<<<${IMAGE} cut -d/ -f2-)
	# pull image
	podman rmi "${IMG}"
	podman pull --tls-verify=false "localhost:5000/${IMG}"
done
