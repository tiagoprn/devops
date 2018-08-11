#!/bin/bash
IMAGES_DIR=$HOME/distros/images
IMAGE_NAME=arch-openstack-LATEST-image-bootstrap
QCOW2_IMAGE_NAME=$IMAGE_NAME.qcow2
QCOW2_TEMPLATE_NAME=$IMAGE_NAME.template.qcow2
mkdir -p $IMAGES_DIR
cd $IMAGES_DIR

echo 'Downloading image...'
if [ ! -f $IMAGES_DIR/$QCOW2_IMAGE_NAME ]; then
    wget https://linuximages.de/openstack/arch/$QCOW2_IMAGE_NAME
fi

echo 'Transforming this image into a template...'
mv $QCOW2_IMAGE_NAME $QCOW2_TEMPLATE_NAME

echo 'DONE. The images is at' $IMAGES_DIR '.'
