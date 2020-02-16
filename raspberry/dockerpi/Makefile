.PHONY: help modify-raspbian-image
SHELL := /bin/bash
SHARED_FOLDER=/tmp/shared-docker-$(shell date +%Y%m%d_%H%M%S)
RASPBERRY_IMAGES_PATH=/storage/raspberry/images
RASPBIAN_COMPRESSED_IMAGE=2020-02-13-raspbian-buster-lite.zip
RASPBIAN_IMAGE=2020-02-13-raspbian-buster-lite.img
FULL_RASPBIAN_IMAGE_PATH=$(RASPBERRY_IMAGES_PATH)/$(RASPBIAN_IMAGE)

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

unzip-raspbian-image:  ## Unzip raspbian image
	@cd $(RASPBERRY_IMAGES_PATH) && unzip $(RASPBIAN_COMPRESSED_IMAGE)

modify-raspbian-image: unzip-raspbian-image  ## Modify raspbian image, mounting /boot and adding ssh file to allow ssh on startup
	@FULL_RASPBIAN_IMAGE_PATH=$(FULL_RASPBIAN_IMAGE_PATH) ./mount-raspbian-image-and-enable-ssh-boot.sh

run-raspbian-interactive: unzip-raspbian-image  ## Run the raspbian docker image locally
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -it --env-file .env --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=$(FULL_RASPBIAN_IMAGE_PATH),target=/sdcard/filesystem.img lukechilds/dockerpi:vm

run-raspbian-ssh: modify-raspbian-image  ## Run the raspbian docker image locally with ssh server
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -d -p 127.0.0.1:5022:5022 --env-file .env --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=$(FULL_RASPBIAN_IMAGE_PATH),target=/sdcard/filesystem.img lukechilds/dockerpi:vm

