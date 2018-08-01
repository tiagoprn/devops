.EXPORT_ALL_VARIABLES:
SHELL=/bin/bash

help:
	@echo -e " make generate_env                   - Create the environment variables for redash."
	@echo -e " make env                            - Load the environment variables."
	@echo -e " make restore_redash_collect_metrics - Restore redash collectd metrics dashboard."	
	@echo -e " make backup_redash_database         - Backup redash postgres database volume."
	@echo -e " make restore_redash_database        - Restore redash postgres database volume."
	@echo -e " make setup_database                 - Create the initial postgres database."
	@echo -e " make redash_server                  - Log on the redash server."
	@echo -e " make redash_worker                  - Log on the redis worker."
	@echo -e " make database                       - Log on the postgresql instance on bash."
	@echo -e " make psql                           - Log on the postgresql instance on psql."
	@echo -e " make up                             - Run docker-compose."
	@echo -e " make run                            - USE THIS COMMAND to start the stack, it makes sure the database is also properly inittiated."

generate_env:
	@bash generate_env.sh

env: generate_env
	source redash.env

restore_redash_collectd_metrics: env
	docker exec -t $$(docker ps | grep postgres | awk '{print $$1}') /utils/restore_tables.sh

backup_redash_database: env
	docker exec -t $$(docker ps | grep postgres | awk '{print $$1}') /utils/dump.sh

restore_redash_database: env
	docker exec -t $$(docker ps | grep postgres | awk '{print $$1}') /utils/restore.sh

setup_database: env
	sleep 10
	docker exec -t $$(docker ps | grep postgres | awk '{print $$1}') /utils/setup.sh
	sleep 10
	docker exec -t $$(docker ps | grep redash_server | awk '{print $$1}') python manage.py database create_tables

redash_server:
	docker exec -it $$(docker ps | grep redash_server | awk '{print $$1}') bash

redash_worker:
	docker exec -it $$(docker ps | grep redash_worker | awk '{print $$1}') bash

database: env
	docker exec -it $$(docker ps | grep postgres_redash | awk '{print $$1}') bash

psql: env
	docker exec -it $$(docker ps | grep postgres_redash | awk '{print $$1}') psql -U redash redash

up: 
	docker-compose rm -f && docker-compose up -d 
  
run: env up setup_database
	@echo -e 'Ready. If you are running locally, point your browser to: http://172.17.0.1, login with user=devops@localhost.localdomain and password=admin12345678 (and please, for you safety change this user password as soon as possible ;)' 
