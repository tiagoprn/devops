SHELL := /bin/bash  # necessary to use the source command, which is not on sh, Makefile's default shell ;)

help:
	@echo -e " make env      - Load the environment variables."
	@echo -e " make bash     - Run a bash session."
	@echo -e " make psql     - Log on the postgresql instance on psql."
	@echo -e " make backup   - Make a backup of postgresql data."
	@echo -e " make restore  - Restore to the most recent database backup."
	@echo -e " make stop     - Stop the container."
	@echo -e " make remove   - Remove (delete) the container."
	@echo -e " make start    - Start the container. If there is another instance of it running, it will be killed and removed first."
	@echo -e " make setupdb  - Setup database credentials and default encoding to be ready for a django app."

env:
	source postgres.env

bash:
	docker exec -it $$(docker ps | grep postgres | awk '{print $$1}') bash

psql: env
	docker exec -it $$(docker ps | grep postgres | awk '{print $$1}') psql -U notepy notepy

backup: env
	docker exec -i $$(docker ps | grep postgres | awk '{print $$1}') /utils/dump.sh

restore: env
	docker exec -i $$(docker ps | grep postgres | awk '{print $$1}') /utils/restore.sh

stop: 
	sudo docker-compose stop 

remove: stop
	sudo docker-compose rm -f

start: remove 
	sudo docker-compose up -d
	@echo -e "IMPORTANT: If this is the first time you start this container, run: \n    $ make setupdb"

setupdb: env start
	docker exec -i $$(docker ps | grep postgres | awk '{print $$1}') /utils/setup.sh
