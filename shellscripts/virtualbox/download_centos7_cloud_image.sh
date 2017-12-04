#!/bin/bash
IMAGES_DIR=$HOME/distros/images
IMAGE_NAME=CentOS-7-x86_64-GenericCloud
QCOW2_IMAGE_NAME=$IMAGE_NAME.qcow2
VBOX_IMAGE_NAME=$IMAGE_NAME.template.vdi
COMPRESSED_IMAGE_NAME=$QCOW2_IMAGE_NAME.xz
mkdir -p $IMAGES_DIR
cd $IMAGES_DIR

echo 'Downloading image...'
if [ ! -f $IMAGES_DIR/$COMPRESSED_IMAGE_NAME ]; then
    wget http://cloud.centos.org/centos/7/images/$COMPRESSED_IMAGE_NAME;
fi

echo 'Decompressing image...'
xz -dk $COMPRESSED_IMAGE_NAME

echo 'Converting image to virtualbox format...'
qemu-img convert -f qcow2 $QCOW2_IMAGE_NAME -O vdi $VBOX_IMAGE_NAME

echo 'DONE. The images are on' $IMAGES_DIR '.'
