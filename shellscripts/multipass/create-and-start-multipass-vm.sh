#!/bin/bash

SYNTAX="./create-and-start-multipass-vm.sh -c 1 -d 5G -m 1G"

while getopts c:d:m: option; do
	case $option in
		c) CPUS=${OPTARG};;
		d) DISK=${OPTARG};;
		m) MEMORY=${OPTARG};;
	esac
done

echo 'Parsing script parameters...'

if [[ -z $CPUS ]]; then
    echo -e "Missing -c parameter. Assuming default value.";
    CPUS=1
fi

if [[ -z $DISK ]]; then
    echo -e "Missing -d parameter. Assuming default value.";
    DISK=5G
fi

if [[ -z $MEMORY ]]; then
    echo -e "Missing -m parameter. Assuming default value.";
    MEMORY=1G
fi

VM_NAME=ubuntu-lts-$(date +%Y%m%d-%H%M%S)
./generate-cloud-config.sh
multipass launch -n $VM_NAME -c $CPUS -d $DISK -m $MEMORY --cloud-init cloud-config.yaml && \
multipass list && \

echo -e "\n---\nFINISHED. VM $VM_NAME created with CPUS=$CPUS, DISK=$DISK and MEMORY=$MEMORY. Have fun! o/".

