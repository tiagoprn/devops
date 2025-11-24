SHELL := /bin/bash

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

bash:  ## Run a bash session
	docker exec -it $$(docker ps | grep magicmirror | awk '{print $$1}') bash

stop:  ## Stop the container.
	docker compose stop

remove: stop  ## Remove (delete) the container.
	docker compose rm -f

up: remove  ## Start the container with the current user and group.
	UID=$$(id -u) GID=$$(id -g) docker compose up -d
	@printf '\n --- \nTo open the WebUI, go to http://localhost:2814\n --- \n'
