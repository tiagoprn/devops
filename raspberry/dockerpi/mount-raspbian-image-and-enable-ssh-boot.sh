#!/bin/bash
# modify the raspbian image to allow auto start of the ssh daemon
FULL_RASPBIAN_IMAGE_PATH=2020-02-05-raspbian-buster-lite.img
bootLoopDevice="$(sudo kpartx -avs $FULL_RASPBIAN_IMAGE_PATH | head -n 1 | awk '{print $3}')"
# add ssh file to boot partition to activate ssh directly during raspbian start
mkdir boot
sudo mount -o loop "/dev/mapper/${bootLoopDevice}" boot
sudo touch boot/ssh
sudo umount boot
sudo rm -fr boot
# FIXME: change raspi hostname to rpi-gateway
sudo kpartx -d $FULL_RASPBIAN_IMAGE_PATH
