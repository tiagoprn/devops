#!/bin/bash

while getopts ":n:t:i:" opt; do
  case $opt in
    n) VM_NAME="$OPTARG"
    ;;
    t) VM_TEMPLATE_NAME="$OPTARG"
    ;;
    i) CLOUD_DATA_ISO="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo 'HELP: -n [new_vm_name] -t [existing_vm_template] -i [cloud-init-data-iso-full-path]'

if [ ! -f $CLOUD_DATA_ISO ]; then
    echo $CLOUD_DATA_ISO 'not found!';
    exit 1;
fi

echo 'Powering off VM...'
vboxmanage controlvm $VM_NAME poweroff 

echo 'Deleting VM...'
vboxmanage unregistervm $VM_NAME --delete 

echo 'Cloning VM...'
vboxmanage clonevm $VM_TEMPLATE_NAME --name $VM_NAME --register

echo 'Attaching cloud-init ISO to VM...'
vboxmanage storageattach $VM_NAME --storagectl IDE --port 0 --device 0 --type dvddrive --medium $CLOUD_DATA_ISO 

echo 'Starting VM...'
vboxmanage startvm $VM_NAME --type headless

echo 'DONE. Have fun!'
