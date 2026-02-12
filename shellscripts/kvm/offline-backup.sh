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

echo -e 'Make sure that:\n\n1) the \033[33mVM\033[0m is \033[33mshut off\033[0m;'

echo -e '2) You have inserted the \033[33mexternal SSD\033[0m labeled as "\033[33mKVM BACKUPS\033[0m" and that it is mounted at "\033[33m/media/temp\033[0m".'

echo -e '\nPress ENTER when ready to continue.'
read -r

TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"

BACKUPS_ROOT=/media/temp/$VM_NAME
BACKUPS_DIR=$BACKUPS_ROOT/$TIMESTAMP
# Append the suffix to the backup directory if provided
BACKUPS_DIR="${BACKUPS_DIR}${BACKUP_SUFFIX:+.$BACKUP_SUFFIX}"

mkdir -p "$BACKUPS_DIR"

echo 'Backing up VM configuration...'
sudo virsh -c qemu:///system dumpxml "$VM_NAME" >"$BACKUPS_DIR/config.xml"

echo 'Identifying VM disk path...'
VM_DISK_FILE="/kvm/$VM_NAME/disk/$VM_NAME.qcow2"
echo -e "VM disk path is '$VM_DISK_FILE'."

echo "Backing up the VM disk at $VM_DISK_FILE..."
sudo rsync -av --progress "$VM_DISK_FILE" "$BACKUPS_DIR"

if [ $? -ne 0 ]; then
    exit 1
fi

echo "DONE. The backup is at $BACKUPS_DIR : "
ls -lha "$BACKUPS_DIR"
