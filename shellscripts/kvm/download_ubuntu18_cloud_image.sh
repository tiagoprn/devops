#!/bin/bash
IMAGES_DIR=$HOME/distros/images
BASE_IMAGE_NAME=bionic-server-cloudimg-i386
DOWNLOAD_IMAGE_NAME=$BASE_IMAGE_NAME.img
QCOW2_IMAGE_NAME=$BASE_IMAGE_NAME.qcow2
QCOW2_TEMPLATE_NAME=ubuntu-1804-i386.template.qcow2
mkdir -p $IMAGES_DIR
cd $IMAGES_DIR

echo 'Downloading image...'
if [ ! -f $IMAGES_DIR/$QCOW2_TEMPLATE_NAME ]; then
    wget https://cloud-images.ubuntu.com/bionic/current/$DOWNLOAD_IMAGE_NAME;
fi

qemu-img convert -f raw -O qcow2 $DOWNLOAD_IMAGE_NAME $QCOW2_IMAGE_NAME

echo 'Transforming this image into a template...'
mv $QCOW2_IMAGE_NAME $QCOW2_TEMPLATE_NAME

echo 'DONE. The image is at' $IMAGES_DIR '.'
