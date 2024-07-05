#!/bin/bash
set -euxo pipefail

yum localinstall --allowerasing --nogpgcheck --disablerepo=* -y $@
