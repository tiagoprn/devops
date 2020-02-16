#!/bin/bash

echo 'Add 10 GB to the image file..'
qemu-img resize -f raw $FULL_RASPBIAN_IMAGE_PATH +10G

echo 'Setup the image as a loopback device, so it can be manipulated with tools as gparted, etc...'
LOOPBACK_MOUNT=$(sudo udisksctl loop-setup -f $FULL_RASPBIAN_IMAGE_PATH | grep -o -m 1 -P -e "/dev/loop[0-9]+")
echo "Image setup as loopback mount at $LOOPBACK_MOUNT"

# exit 1  # REMOVE on the final version, just testing here...

echo 'Listing block devices...'
lsblk

# TODO: To automate below, I could also use `resize2fs /dev/loopxxx SIZE`, using information from /dev/loop on lsblk.
# echo 'Preparing to resize the 2nd partition on the image loopback device...'
# sudo e2fsck -y -f "$LOOPBACK_MOUNT"p2
# echo 'Resize the 2nd partition, the one with the filesystem...'
# sudo parted $LOOPBACK_MOUNT resizepart 2

echo 'Will run gparted now on the loopback device, you must manually resize the partition to the grown space...'
sudo gparted $LOOPBACK_MOUNT

echo 'Delete the mapped loopback device'
sudo udisksctl loop-delete -b $LOOPBACK_MOUNT

echo 'Finished.'
