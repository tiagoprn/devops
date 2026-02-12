#!/usr/bin/env bash

# e.g.
SYNTAX="./offline-backup.sh -n [VM_NAME] -s [BACKUP-SUFFIX]"
HELP="./offline-backup.sh -n centos7-02 -s 'initial-backup'"

while getopts n:b:r:c:s: option; do
    case "${option}" in
        n) VM_NAME=${OPTARG} ;;
        s) BACKUP_SUFFIX=${OPTARG} ;;
    esac
done

# If the suffix is not provided, set it to an empty string
BACKUP_SUFFIX=${BACKUP_SUFFIX:-""}

echo 'Parsing script parameters...'
if [[ -z $VM_NAME ]]; then
    printf "Missing -n parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n"
    exit 1
fi

TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"

BACKUPS_ROOT=/media/temp/$VM_NAME
BACKUPS_DIR=$BACKUPS_ROOT/$TIMESTAMP
# Append the suffix to the backup directory if provided
BACKUPS_DIR="${BACKUPS_DIR}${BACKUP_SUFFIX:+.$BACKUP_SUFFIX}"

mkdir -p "$BACKUPS_DIR"

echo 'Backing up VM configuration...'
sudo virsh -c qemu:///system dumpxml "$VM_NAME" >"$BACKUPS_DIR/config.xml"

echo 'Identifying VM disk path...'
VM_PATH=$(sudo virsh -c qemu:///system domblklist "$VM_NAME" | grep vda | awk '{print $2}')
echo -e "VM disk path is '$VM_PATH'. \nMake sure the VM is shut off now. Press ENTER when ready to continue."

# TODO: command to "press enter to continue here"

BACKUP_NAME="$VM_NAME.$TIMESTAMP"

echo "Backing up the VM disk at $($VM_PATH)..."
sudo cp -farv "$VM_PATH" "$BACKUPS_DIR"

if [ $? -ne 0 ]; then
    exit 1
fi

echo "DONE. The backup is at $BACKUPS_DIR."
