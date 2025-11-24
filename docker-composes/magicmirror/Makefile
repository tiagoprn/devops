SHELL := /bin/bash

MM_UID := $(shell id -u)
MM_GID := $(shell id -g)

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

bash:  ## Run a bash session
	docker exec -it $$(docker ps | grep magicmirror | awk '{print $$1}') bash

stop:  ## Stop the container.
	docker compose stop

remove: stop  ## Remove (delete) the container.
	docker compose rm -f

up: remove  ## Start the container with the current user and group.
	mkdir -p ./config
	mkdir -p ./custom_modules
	chown -R $(MM_UID):$(MM_GID) ./config
	chown -R $(MM_UID):$(MM_GID) ./custom_modules
	MM_UID=$(MM_UID) MM_GID=$(MM_GID) docker compose up -d
	@printf '\n --- \nTo open the WebUI, go to http://localhost:2814\n --- \n'
