SHELL := /bin/bash  # necessary to use the source command, which is not on sh, Makefile's default shell ;)

help:
	@echo -e " make vars                           - Export environment variables to backup/restore redash database."
	@echo -e " make backup_redash_database         - Backup redash postgres database volume."
	@echo -e " make restore_redash_database        - Restore redash postgres database volume."
	@echo -e " make setup_database                 - Create the initial postgres database."
	@echo -e " make redash_server                  - Log on the redash server."
	@echo -e " make redash_worker                  - Log on the redis worker."
	@echo -e " make postgres                       - Log on the postgresql instance on psql."
	@echo -e " make up                             - Run docker-compose."
	@echo -e " make run                            - USE THIS COMMAND to start the stack, it makes sure the database is also properly inittiated."

vars:
	export REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR=/storage/containers/backups/volumes/postgres_redash

backup_redash_database: vars
	mkdir -p $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR
	echo 'Starting backup of redash postgres database... '
	./docker_volume_backup.sh docker-compose.yml postgres $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR backup
	echo 'Backup finished.'

restore_redash_database: vars
	echo 'These are the available backups: '
	ls $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR
	echo 'Which backup you want to restore?'
	read RESTORE
	echo 'Restoring $$RESTORE... '
	./docker_volume_backup.sh docker-compose.yml postgres $$REDASH_POSGRES_DOCKER_VOLUME_BACKUP_DIR restore $$RESTORE
	echo 'Restoration finished.'

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

