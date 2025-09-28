FROM iobrokerk8s/base-adapter:local-latest

ARG ADAPTER_NAME

RUN npm install iobroker.${ADAPTER_NAME} && npm cache clean --force

ENV IOB_K8S_ADAPTER=${ADAPTER_NAME}