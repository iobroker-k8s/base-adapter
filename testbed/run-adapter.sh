#!/bin/bash

set -e

# if number of arguments is not at least 2, show usage
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <adapter_name> <command> [<args>]"
  echo "  <adapter_name>  Name of the adapter to run"
  echo "  <command>      Command to run inside the adapter (start, add, ...)"
  echo "  [<args>]       Optional arguments for the command"
  echo ""
  echo "You can also set the ADAPTER_INSTANCE environment variable to "
  echo "specify the instance number (default is 0)."
  exit 1
fi

docker build -t iobrokerk8s/base-adapter:local-latest ..

ADAPTER_NAME=$1
shift
COMMAND=$@

if [ -z "$ADAPTER_INSTANCE" ]; then
  ADAPTER_INSTANCE=0
fi

docker build \
    -t iobrokerk8s/adapter-${ADAPTER_NAME}:local-latest \
    . \
    --build-arg "ADAPTER_NAME=${ADAPTER_NAME}"

docker run -it --rm \
  -e IOB_K8S_HOSTNAME=k8s-cluster \
  -e IOB_K8S_INSTANCE=$ADAPTER_INSTANCE \
  --network testbed_default \
  -v ./iobroker-data:/app/iobroker-data \
  iobrokerk8s/adapter-${ADAPTER_NAME}:local-latest \
  ${COMMAND}