#!/bin/bash
set -xo pipefail

for IMAGE in $@; do
	podman image exists "${IMAGE}"
	[ $? -eq 1 ] && podman image pull "${IMAGE}" || true
done
