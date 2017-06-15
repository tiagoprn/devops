help:
	@echo -e " make bash                               - Run a bash session."
	@echo -e " make postgres                           - Log on the postgresql instance."
	@echo -e " make postgrespsql                       - Log on the postgresql instance on psql."
	@echo -e " make postgresbkp                        - Make a backup of postgresql data."

bash:  
	docker exec -it $$(docker ps | grep runtime | awk '{print $$1}') bash

postgres:
	docker exec -it $$(docker ps | grep _database_1 | awk '{print $$1}') bash

postgrespsql:
	docker exec -it $$(docker ps | grep _database_1 | awk '{print $$1}') psql -U tmc tmc_financeiro

postgresbkp:
	docker exec -i $$(docker ps | grep _database_1 | awk '{print $$1}') /utils/dump.sh
