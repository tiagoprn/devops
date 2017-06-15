help:
	@echo -e " make bash                               - Run a bash session."
	@echo -e " make rediscli                           - Run a redis-cli session."

bash:  
	docker exec -it $$(docker ps | grep redis | awk '{print $$1}') bash

rediscli:
	docker exec -it $$(docker ps | grep redis | awk '{print $$1}') redis-cli
