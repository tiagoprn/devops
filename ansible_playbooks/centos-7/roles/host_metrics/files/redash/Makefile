help:
	@echo -e " make setup_database                 - Create the initial postgres database."
	@echo -e " make redash_server                  - Log on the redash server."
	@echo -e " make redash_worker                  - Log on the redis worker."
	@echo -e " make postgres                       - Log on the postgresql instance on psql."
	@echo -e " make up                             - Run docker-compose."
	@echo -e " make run                            - USE THIS COMMAND to start the stack, it makes sure the database is also properly inittiated."

# TODO: call the scripts to backup/restore the redash postgres docker volume here.

setup_database:
	docker exec -t $$(docker ps | grep redash_server | awk '{print $$1}') python manage.py database create_tables

redash_server:
	docker exec -it $$(docker ps | grep redash_server | awk '{print $$1}') bash

redash_worker:
	docker exec -it $$(docker ps | grep redash_worker | awk '{print $$1}') bash

postgres:
	docker exec -it $$(docker ps | grep redash_postgres | awk '{print $$1}') psql -U redash redash

up: 
	docker-compose rm -f && docker-compose up -d 
  
run: up setup_database
	@echo -e 'Ready. If you are running locally, point your browser to: http://172.17.0.1:8555 and have fun! =D' 

