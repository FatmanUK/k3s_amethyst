#!/bin/bash
set -euxo pipefail

/usr/local/bin/kubectl completion bash | tee /etc/profile.d/bbsh_completion_kubectl.sh
