help:
	@echo -e " make bash                               - Run a bash session."
	@echo -e " make mongo                              - Run a mongo cli client session."

bash:  
	docker exec -it $$(docker ps | grep mongo | awk '{print $$1}') bash

mongo:
	docker exec -it $$(docker ps | grep mongo | awk '{print $$1}') mongo
