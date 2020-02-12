.PHONY: help
SHELL := /bin/bash
SHARED_FOLDER=/tmp/shared-docker-$(shell date +%Y%m%d_%H%M%S)

# docker run -it -v /2019-09-26-raspbian-buster-lite.img:/sdcard/filesystem.img lukechilds/dockerpi

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

build:  ## Build the docker image locally
	@docker build -t lukechilds/dockerpi .

run: ## Run the app docker image locally
	echo "You can exchange files with this containers on the directory $(SHARED_FOLDER) on the host and /shared on the container."
	mkdir -p $(SHARED_FOLDER)
	@docker run -it --env-file .env --network bridge --mount type=bind,source=$(SHARED_FOLDER),target=/shared lukechilds/dockerpi


