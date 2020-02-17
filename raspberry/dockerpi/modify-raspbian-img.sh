#!/bin/bash
# This script modifies the raspbian image with some customizations.

echo "Mount boot partition of raspbian image at $FULL_RASPBIAN_IMAGE_PATH..."
bootLoopDevice="$(sudo kpartx -avs $FULL_RASPBIAN_IMAGE_PATH | head -n 1 | awk '{print $3}')"
mkdir boot
sudo mount -o loop "/dev/mapper/${bootLoopDevice}" boot

echo "Mount root partition of raspbian image at $FULL_RASPBIAN_IMAGE_PATH..."
rootLoopDevice="$(sudo kpartx -avs $FULL_RASPBIAN_IMAGE_PATH | tail -n 1 | awk '{print $3}')"

echo "Add ssh file to root partition to activate ssh directly during raspbian start..."
mkdir root
sudo mount -o loop "/dev/mapper/${rootLoopDevice}" root

echo "Add ssh file to boot partition to activate ssh directly during raspbian start..."
sudo touch boot/ssh

echo "Add first_boot.sh script with commands to run on first_boot..."
sudo cp first_boot.sh root/opt/first_boot.sh

echo "Add rc.local to allow running the first_boot script..."
sudo cp root/etc/rc.local root/etc/rc.local.ORIG
sudo cp config/rc.local root/etc

echo "Add locale configuration..."
sudo cp root/etc/default/locale root/etc/default/locale.ORIG
sudo cp config/locale root/etc/default/locale
sudo cp root/etc/locale.gen root/etc/locale.gen.ORIG
sudo cp config/locale.gen root/etc/locale.gen

echo "Add sshd configuration..."
sudo cp root/etc/ssh/sshd_config root/etc/ssh/sshd_config.ORIG
sudo cp config/sshd_config root/etc/ssh/sshd_config

echo "Generating and copying ssh authorized_keys file..."
cat $HOME/.ssh/id_rsa.pub > config/authorized_keys
sudo su -c "mkdir -p root/home/pi/.ssh"
sudo su -c "cp config/authorized_keys root/home/pi/.ssh/authorized_keys"
sudo su -c "chown -R 1000:1000 root/home/pi/.ssh"
sudo su -c "chmod 700 root/home/pi/.ssh"
sudo su -c "chmod 644 root/home/pi/.ssh/authorized_keys"

echo "Umounting and removing raspbian boot filesystem mapping..."
sudo umount boot
sudo rm -fr boot

echo "Umounting and removing raspbian root filesystem mapping..."
sudo umount root
sudo rm -fr root

sudo kpartx -d $FULL_RASPBIAN_IMAGE_PATH
echo "Finished mounting and modifying raspbian image at $FULL_RASPBIAN_IMAGE_PATH."
