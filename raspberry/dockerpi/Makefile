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
	@echo "When/if asked for, answer [n]o to the question to replace the image if you want to keep the existing image."
	@sleep 3
	@cd $(RASPBERRY_IMAGES_PATH) && unzip $(RASPBIAN_COMPRESSED_IMAGE)

modify-raspbian-image: unzip-raspbian-image  ## Modify raspbian image, mounting /boot to add ssh file to allow ssh on startup and install cloud-init and its configuration
	@FULL_RASPBIAN_IMAGE_PATH=$(FULL_RASPBIAN_IMAGE_PATH) ./modify-raspbian-img.sh

resize-raspbian-image: ## Resize raspbian image, so that it can have free space to be usable.
	@FULL_RASPBIAN_IMAGE_PATH=$(FULL_RASPBIAN_IMAGE_PATH) ./resize-raspbian-img.sh

run-raspbian-interactive: unzip-raspbian-image  ## Run the raspbian docker image locally
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -it --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=$(FULL_RASPBIAN_IMAGE_PATH),target=/sdcard/filesystem.img lukechilds/dockerpi:vm

run-dockerized-raspbian-ssh: modify-raspbian-image  ## Run the raspbian docker image locally with ssh server
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -d --name raspbian-$$(date '+%Y%m%d.%H%M.%S') -p 127.0.0.1:5022:5022 --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared --mount type=bind,source=$(FULL_RASPBIAN_IMAGE_PATH),target=/sdcard/filesystem.img lukechilds/dockerpi:vm

run-raspbian-ssh: run-dockerized-raspbian-ssh  ## Run the raspbian docker image locally with ssh server, tailing its logs
	@echo -e '>>> After seeing on the logs below the openssh server is started, you can ssh to it'
	@sleep 5
	@docker logs -f $$(docker ps -f name=raspbian | cut -d ' ' -f 1 | grep -v CONTAINER)

ssh-into-raspbian:  ## ssh into the raspbian docker container
	@echo 'Removing old ssh record'
	@ssh-keygen -f "/home/tiago/.ssh/known_hosts" -R "[localhost]:5022" || true
	@echo 'Enter password: "raspberry" when prompted for it.'
	@ssh pi@localhost -p 5022
