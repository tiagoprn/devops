SHELL := /bin/bash  # necessary to use the source command, which is not on sh, Makefile's default shell ;)
help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

bash:  ## Run a bash session
	docker exec -it $$(docker ps | grep rabbitmq-borg_enhancements | awk '{print $$1}') bash

management:  ## Run a management command to list available exchanges
	@set -a && source rabbitmq.env && set +a && docker exec -i $$(docker ps | grep rabbitmq-borg_enhancements | awk '{print $$1}') rabbitmqadmin --username=$$RABBITMQ_DEFAULT_USER --password=$$RABBITMQ_DEFAULT_PASS list exchanges

stop:  ## Stop the container."
	docker-compose stop

remove: stop  ## Remove (delete) the container."
	docker-compose rm -f

up: remove  ## Start the container. If there is another instance of it running, it will be killed and removed first."
	docker-compose up -d
	@printf '\n --- \nTo run the administrative interface, go to http://localhost:15672, user: $$RABBITMQ_DEFAULT_USER, password: $$RABBITMQ_DEFAULT_PASS.\n --- \n'
