help:
	@echo -e " make bash                               - Run a bash session."

bash:  
	docker exec -it $$(docker ps | grep rabbitmq | awk '{print $$1}') bash
