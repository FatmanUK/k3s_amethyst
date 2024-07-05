#!/bin/bash
set -euxo pipefail

/usr/bin/tar cvpzf "$1" -C "$2" ${@:3}
