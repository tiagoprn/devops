SHELL := /bin/bash  # necessary to use the source command, which is not on sh, Makefile's default shell ;)

help:
	@echo -e " make env                                - Load the environment variables."
	@echo -e " make bash                               - Run a bash session."
	@echo -e " make postgrespsql                       - Log on the postgresql instance on psql."
	@echo -e " make postgresbkp                        - Make a backup of postgresql data."

env:
	source postgres.env

bash:
	docker exec -it $$(docker ps | grep postgres | awk '{print $$1}') bash

postgrespsql: env
	docker exec -it $$(docker ps | grep postgres | awk '{print $$1}') psql -U notepy notepy

postgresbkp: env
	docker exec -i $$(docker ps | grep postgres | awk '{print $$1}') /utils/dump.sh
