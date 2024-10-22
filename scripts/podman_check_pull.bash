#!/bin/bash
set -o pipefail

for IMAGE in $@; do
	podman image exists "${IMAGE}"
	I=$?
	if [ $I -eq 0 ]; then
		echo "Image already exists." >&2
	elif [ $I -eq 1 ]; then
		podman image pull "${IMAGE}" || true
		echo "Fetched image."
	else
		echo "Unknown error." >&2
	fi
done
