#!/bin/bash

set -e

# if number of arguments is not at least 2, show usage
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <adapter_name> <command> [<args>]"
  echo "  <adapter_name>  Name of the adapter to run"
  echo "  <command>      Command to run inside the adapter (start, add, ...)"
  echo "  [<args>]       Optional arguments for the command"
  exit 1
fi

docker build -t iobrokerk8s/base-adapter:local-latest ..

ADAPTER_NAME=$1
shift
COMMAND=$@

docker build \
    -t iobrokerk8s/adapter-${ADAPTER_NAME}:local-latest \
    . \
    --build-arg "ADAPTER_NAME=${ADAPTER_NAME}"

docker run -it --rm \
  -e IOB_K8S_INSTANCE=0 \
  --network testbed_default \
  -v ./iobroker-data:/app/iobroker-data \
  iobrokerk8s/adapter-${ADAPTER_NAME}:local-latest \
  ${COMMAND}