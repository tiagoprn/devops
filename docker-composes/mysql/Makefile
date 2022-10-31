help:
	@echo -e " make bash                               - Run a bash session."
	@echo -e " make mysql-cli                          - Enter the mysql-cli."

bash:  
	docker exec -it $$(docker ps | grep mysql | awk '{print $$1}') bash

mysql-cli:
	docker exec -it $$(docker ps | grep mysql | awk '{print $$1}') mysql

info:
	docker inspect $$(docker ps | grep mysql | awk '{print $$1}')

