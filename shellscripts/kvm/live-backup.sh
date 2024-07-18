#!/bin/bash

# e.g.
SYNTAX="./live-backup.sh -n [VM_NAME]"
HELP="./live-backup.sh -n centos7-02"

while getopts n:b:r:c: option; do
    case "${option}" in
        n) VM_NAME=${OPTARG} ;;
    esac
done

echo 'Parsing script parameters...'
if [[ -z $VM_NAME ]]; then
    printf "Missing -n parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n"
    exit 1
fi

echo 'Creating snapshots dir...'

TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
SNAPSHOTS_DIR=/kvm/snapshots/$VM_NAME/$TIMESTAMP

mkdir -p "$SNAPSHOTS_DIR"

BACKUPS_ROOT=/kvm/backups/$VM_NAME
BACKUPS_DIR=$BACKUPS_ROOT/$TIMESTAMP

mkdir -p "$BACKUPS_DIR"

sudo virsh -c qemu:///system dumpxml "$VM_NAME" >"$BACKUPS_DIR/config.xml"

VM_PATH=$(sudo virsh -c qemu:///system domblklist "$VM_NAME" | grep vda | awk '{print $2}')
BACKUP_NAME="$VM_NAME.$TIMESTAMP"

echo 'Creating the snapshot, so that the disk operations will be directed to it for you to copy the original disk file to a safe place...'

sudo virsh snapshot-create-as --no-metadata --domain "$VM_NAME" "$BACKUP_NAME" --diskspec vda,file="$SNAPSHOTS_DIR"/"$VM_NAME" --disk-only --atomic

echo 'Backing up the original disk...'

cp -farv "$VM_PATH" "$BACKUPS_DIR"

echo 'Creating a compressed copy of the backup...'

tar cfjv "$BACKUPS_ROOT/$BACKUP_NAME.tar.bz2" "$BACKUPS_DIR"

echo 'Redirecting disk operations to the original disk...'

sudo virsh blockcommit "$VM_NAME" vda --active --pivot --shallow --verbose

echo "DONE. The unpacked backup is at $BACKUPS_DIR."
