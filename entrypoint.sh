#!/bin/sh
set -e

if [ -z "$IOB_K8S_HOSTNAME" ]; then
    echo "Error: IOB_K8S_HOSTNAME environment variable must be set"
    exit 1
fi
if [ -z "$IOB_K8S_ADAPTER" ]; then
    echo "Error: IOB_K8S_ADAPTER environment variable must be set"
    exit 1
fi
if [ -z "$IOB_K8S_INSTANCE" ]; then
    echo "Error: IOB_K8S_INSTANCE environment variable must be set"
    exit 1
fi

export IOB_HOSTNAME=$IOB_K8S_HOSTNAME 

if [ "$1" = "start" ]; then
    echo "Starting adapter $IOB_K8S_ADAPTER.$IOB_K8S_INSTANCE"
    cd /app/node_modules
    shift
    set -x
    node iobroker.$IOB_K8S_ADAPTER --instance $IOB_K8S_INSTANCE "$@"
else
    cd /app
    node . "$@"
fi