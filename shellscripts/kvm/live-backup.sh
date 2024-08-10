#!/usr/bin/env bash

# e.g.
SYNTAX="./live-backup.sh -n [VM_NAME]"
HELP="./live-backup.sh -n centos7-02"

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

echo 'Creating snapshots dir...'

# The primary purpose of creating a snapshot in this script is to temporarily redirect disk operations to a new file so
# that the original qcow2 image can be safely backed up without any changes occurring during the copy process.

# When you create a snapshot, the VM continues to write changes to the new snapshot file,
# while the original disk image remains in a consistent state, allowing for a safe backup.
# After copying the original qcow2 image, you commit the snapshot back to the original disk image, merging any changes made during the snapshot period.

TIMESTAMP="$(date "+%Y%m%d.%H%M.%S")"
SNAPSHOTS_DIR=/kvm/snapshots/$VM_NAME/$TIMESTAMP

mkdir -p "$SNAPSHOTS_DIR"

BACKUPS_ROOT=/kvm/backups/$VM_NAME
BACKUPS_DIR=$BACKUPS_ROOT/$TIMESTAMP
# Append the suffix to the backup directory if provided
BACKUPS_DIR="${BACKUPS_DIR}${BACKUP_SUFFIX:+_$BACKUP_SUFFIX}"

mkdir -p "$BACKUPS_DIR"

echo 'Saving VM configuration...'
sudo virsh -c qemu:///system dumpxml "$VM_NAME" >"$BACKUPS_DIR/config.xml"

echo 'Identifying VM disk path...'
VM_PATH=$(sudo virsh -c qemu:///system domblklist "$VM_NAME" | grep vda | awk '{print $2}')
echo -e "VM disk path is '$VM_PATH'. \nMake sure it is not a snapshot. \nIf it is, you must retry the blockcommit command the end of this script.\nDo you want to continue?"

BACKUP_NAME="$VM_NAME.$TIMESTAMP"

echo 'Creating the snapshot, so that the disk operations will be directed to it for you to copy the original disk file to a safe place...'
sudo virsh snapshot-create-as --no-metadata --domain "$VM_NAME" "$BACKUP_NAME" --diskspec vda,file="$SNAPSHOTS_DIR"/"$VM_NAME" --disk-only --atomic --memspec

echo "Backing up the original disk at $($VM_PATH)..."
sudo cp -farv "$VM_PATH" "$BACKUPS_DIR"

echo 'Creating a compressed copy of the backup...'
tar cfjv "$BACKUPS_ROOT/$BACKUP_NAME.tar.bz2" "$BACKUPS_DIR"

echo 'Redirecting disk operations to the original disk...'
sudo virsh blockcommit "$VM_NAME" vda --active --pivot --shallow --verbose

# Verify the disk path has been redirected back to the original image
NEW_VM_PATH=$(sudo virsh -c qemu:///system domblklist "$VM_NAME" | grep vda | awk '{print $2}')
if [[ $NEW_VM_PATH != "$VM_PATH" ]]; then
    echo -e "Blockcommit failed."
    echo -e "  It did not redirect disk operations back to the original disk. "
    echo -e "  Current disk path: $NEW_VM_PATH"
    echo -e "Retry the blockcommit command manually:\n\n"
    echo -e "sudo virsh blockcommit $VM_NAME vda --active --pivot --shallow --verbose\n\n"
    echo -e "Then, run the command below again and make sure the 'vda' target is the qcow2 disk, NOT the snapshot:\n\n"
    echo -e "sudo virsh -c qemu:///system domblklist $VM_NAME \n\n"
    exit 1
fi

if [ $? -ne 0 ]; then
    exit 1
fi

echo "DONE. The unpacked backup is at $BACKUPS_DIR."
