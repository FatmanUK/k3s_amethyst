#!/bin/bash
set -euxo pipefail

INFILE='/etc/k3s-token'
OUTFILE='/var/lib/rancher/k3s/server/token'
BINARY_BASENAME=$(basename $2)

if [ ! -e ${OUTFILE} ]; then
	install -m0400 -oroot -groot <(<<<$1 more) "${INFILE}"
	$2 server --token-file "${INFILE}" &
	sleep 1
	N=0
	TIMEOUT=120
	while [ ! -f "${OUTFILE}" ] ; do
		sleep 1
		N=$((N + 1))
		[ $N -ge ${TIMEOUT} ] && break
	done
	pkill "${BINARY_BASENAME}"
fi
