.PHONY: help
SHELL := /bin/bash
SHARED_FOLDER=/tmp/shared-docker-$(shell date +%Y%m%d_%H%M%S)
RASPBERRY_IMAGES_PATH=/storage/raspberry/images
RASPBIAN_COMPRESSED_IMAGE=2020-02-13-raspbian-buster-lite.zip
RASPBIAN_IMAGE=2020-02-13-raspbian-buster-lite.img

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

unzip-raspbian-image:   ## Unzip raspbian image
	@cd $(RASPBERRY_IMAGES_PATH) && unzip $(RASPBIAN_COMPRESSED_IMAGE)

run-raspbian-interactive: unzip-raspbian-image  ## Run the raspbian docker image locally
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -it --env-file .env --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=/storage/src/devops/raspberry/dockerpi/2020-02-05-raspbian-buster-lite.img,target=/sdcard/filesystem.img lukechilds/dockerpi:vm

run-raspbian-ssh: unzip-raspbian-image  ## Run the raspbian docker image locally with ssh server
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -d -p 127.0.0.1:5022:5022 --env-file .env --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=/storage/src/devops/raspberry/dockerpi/2020-02-05-raspbian-buster-lite.img,target=/sdcard/filesystem.img lukechilds/dockerpi:vm

