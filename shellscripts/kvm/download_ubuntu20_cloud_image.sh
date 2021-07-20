#!/bin/bash
IMAGES_DIR=$HOME/distros/images
RELEASE_NAME=focal
RELEASE_NUMBER=2004
BASE_IMAGE_NAME=$RELEASE_NAME-server-cloudimg-amd64
DOWNLOAD_IMAGE_NAME=$BASE_IMAGE_NAME.img

IMAGE_NAME=$BASE_IMAGE_NAME.img
TEMPLATE_NAME=ubuntu-$RELEASE_NUMBER-amd64.template.img
mkdir -p "$IMAGES_DIR"
cd "$IMAGES_DIR" || exit 1

echo 'Downloading image...'
if [ ! -f "$IMAGES_DIR/$TEMPLATE_NAME" ]; then
	wget https://cloud-images.ubuntu.com/$RELEASE_NAME/current/$DOWNLOAD_IMAGE_NAME;
fi

echo 'Renaming converted image into a template...'
mv $IMAGE_NAME $TEMPLATE_NAME

echo 'DONE. The image is at' "$IMAGES_DIR" '.'
