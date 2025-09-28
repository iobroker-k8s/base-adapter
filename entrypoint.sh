#!/bin/sh
set -e

# ensure IOB_K8S_ADAPTER and IOB_K8S_INSTANCE are set
if [ -z "$IOB_K8S_ADAPTER" ] || [ -z "$IOB_K8S_INSTANCE" ]; then
    echo "Error: IOB_K8S_ADAPTER and IOB_K8S_INSTANCE environment variables must be set"
    exit 1
fi

if [ "$1" = "start" ]; then
    echo "Starting adapter $IOB_K8S_ADAPTER.$IOB_K8S_INSTANCE"
    cd /app/node_modules
    shift
    set -x
    node iobroker.$IOB_K8S_ADAPTER $IOB_K8S_INSTANCE "$@"
else
    cd /app
    node . "$@"
fi