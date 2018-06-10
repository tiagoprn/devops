.EXPORT_ALL_VARIABLES:
SHELL=/bin/bash
REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR=/storage/containers/backups/volumes/postgres_redash

help:
	@echo -e " make backup_redash_database         - Backup redash postgres database volume."
	@echo -e " make restore_redash_database        - Restore redash postgres database volume."
	@echo -e " make setup_database                 - Create the initial postgres database."
	@echo -e " make redash_server                  - Log on the redash server."
	@echo -e " make redash_worker                  - Log on the redis worker."
	@echo -e " make postgres                       - Log on the postgresql instance on psql."
	@echo -e " make up                             - Run docker-compose."
	@echo -e " make run                            - USE THIS COMMAND to start the stack, it makes sure the database is also properly inittiated."

backup_redash_database:
	@echo -e  $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR
	@echo -e 'Creating $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR if it does not exist... '
	mkdir -p $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR
	@echo -e 'Starting backup of redash postgres database... '
	./docker-volume-backup.sh docker-compose.yml postgres_redash $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR backup
	@echo -e 'Backup finished.'

restore_redash_database:
	@echo -e 'These are the available backups: '
	@ls $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR
	@echo -e 'Which backup you want to restore?'
	@read RESTORE
	@echo -e 'Restoring $$RESTORE... '
	./docker-volume-backup.sh docker-compose.yml postgres_redash $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR restore $$RESTORE
	@echo -e 'Restoration finished.'

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

