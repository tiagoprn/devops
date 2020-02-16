#!/bin/bash

# modify the raspbian image to allow auto start of the ssh daemon
echo "Mount boot partition of raspbian image at $FULL_RASPBIAN_IMAGE_PATH..."
bootLoopDevice="$(sudo kpartx -avs $FULL_RASPBIAN_IMAGE_PATH | head -n 1 | awk '{print $3}')"
mkdir boot
sudo mount -o loop "/dev/mapper/${bootLoopDevice}" boot

echo "Mount root partition of raspbian image at $FULL_RASPBIAN_IMAGE_PATH..."
rootLoopDevice="$(sudo kpartx -avs $FULL_RASPBIAN_IMAGE_PATH | tail -n 1 | awk '{print $3}')"
# add ssh file to root partition to activate ssh directly during raspbian start
mkdir root
sudo mount -o loop "/dev/mapper/${rootLoopDevice}" root

# add ssh file to boot partition to activate ssh directly during raspbian start
sudo touch boot/ssh

# add first_boot.sh script with commands to run on first_boot
sudo cp first_boot.sh root/opt/first_boot.sh
sudo cp root/etc/rc.local root/etc/rc.local.ORIG
sudo cp config/rc.local root/etc

sudo umount boot
sudo rm -fr boot

sudo umount root
sudo rm -fr root

sudo kpartx -d $FULL_RASPBIAN_IMAGE_PATH
echo "Finished mounting and modifying raspbian image at $FULL_RASPBIAN_IMAGE_PATH."
