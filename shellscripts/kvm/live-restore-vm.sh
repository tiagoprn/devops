#!/bin/bash 

# e.g.
SYNTAX="./live-restore-vm.sh -x [XML_CONFIG] -n [VM_NAME] -b [BACKUP_QCOW2_IMAGE] -i [QCOW2_IMAGE]"
HELP="./live-restore-vm.sh -x config.yml -n centos7-02 -b /kvm/backups/20180904/centos.qcow2 -i /kvm/images/centos.qcow2"

while getopts n:b:r:c: option
do
  case "${option}"
  in
  n) VM_NAME=${OPTARG};;
  x) XML_CONFIG=${OPTARG};;
  i) QCOW2_IMAGE=${OPTARG};;
  b) BACKUP_QCOW2_IMAGE=${OPTARG};;
  esac
done

echo 'Parsing script parameters...'
if [[ -z $VM_NAME ]]; then
    printf "Missing -n parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi
if [[ -z $XML_CONFIG ]]; then
    printf "Missing -x parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi
if [[ -z $QCOW2_IMAGE ]]; then
    printf "Missing -i parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi
if [[ -z $BACKUP_QCOW2_IMAGE ]]; then
    printf "Missing -b parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi

TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
echo 'Shutting down vm if it is active...'
sudo virsh shutdown $VM_NAME
echo 'Removing existing vm...'
sudo virsh undefine $VM_NAME
echo 'Removing disk for the existing vm...'
sudo rm -fr $QCOW2_IMAGE 
echo 'Changing kvm config to restoration...'
python change_kvm_config_to_restoration.py -x $XML_CONFIG -n $VM_NAME -b $BACKUP_QCOW2_IMAGE -i $QCOW2_IMAGE
echo 'Copying the backup disk as the vm disk...'
sudo cp -farv $BACKUP_QCOW2_IMAGE $QCOW2_IMAGE
echo 'Restoring vm to the backup image...'
sudo virsh -c qemu:///system define /tmp/restoration.xml  
echo 'Starting the restored vm now...'
sudo virsh -c qemu:///system start $VM_NAME
echo 'DONE.'
