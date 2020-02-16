#!/bin/bash

# Add 10 GB to the image file
qemu-img resize -f raw $FULL_RASPBIAN_IMAGE_PATH +10G

# Setup the image as a loopback device, so it can be manipulated with tools as gparted, etc...
LOOPBACK_MOUNT=$(sudo udisksctl loop-setup -f $FULL_RASPBIAN_IMAGE_PATH | grep -o -m 1 -P -e "/dev/loop[0-9]+")
echo "Image setup as loopback mount at $LOOPBACK_MOUNT"

lsblk

# Resize the 2nd partition, the one with the filesystem. (learned that with gparted)
resize2fs -p "$LOOPBACK_MOUNT"p2

# Delete the mapped loopback device
sudo udisksctl loop-delete -b $LOOPBACK_MOUNT
