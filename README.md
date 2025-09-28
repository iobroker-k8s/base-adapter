# base-adapter
Base image for all adapters running in iobroker-k8s

## Local testing

Inside devcontainer, you can use the following two commands to test this image:

- `./start-iobroker.sh` Starts a docker-compose with valkey and iobroker
- `./run-adapter.sh` Runs an image based on the `base-adapter` image for a given adapter. Examples:
  - `./run-adapter.sh loxone add` Adds instance 0 to ioBroker started with the above command
  - `./run-adapter.sh loxone start` Starts the adapter instance 0