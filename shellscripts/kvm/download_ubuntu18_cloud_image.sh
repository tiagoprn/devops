#!/bin/bash
IMAGES_DIR=$HOME/distros/images
BASE_IMAGE_NAME=bionic-server-cloudimg-amd64
DOWNLOAD_IMAGE_NAME=$BASE_IMAGE_NAME.img

IMAGE_NAME=$BASE_IMAGE_NAME.img
TEMPLATE_NAME=ubuntu-1804-amd64.template.img
mkdir -p $IMAGES_DIR
cd $IMAGES_DIR

echo 'Downloading image...'
if [ ! -f $IMAGES_DIR/$TEMPLATE_NAME ]; then
    wget https://cloud-images.ubuntu.com/bionic/current/$DOWNLOAD_IMAGE_NAME;
fi

echo 'Renaming converted image into a template...'
mv $IMAGE_NAME $TEMPLATE_NAME

echo 'DONE. The image is at' $IMAGES_DIR '.'
