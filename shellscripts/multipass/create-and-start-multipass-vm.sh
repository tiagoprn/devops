#!/bin/bash
IMAGE_NAME=ubuntu-lts-$(date +%Y%m%d_%H%M%S)
./generate-cloud-config.sh
multipass launch -n $IMAGE_NAME --cloud-init cloud-config.yaml && \
multipass list && \
echo "Image created and started as $IMAGE_NAME".

