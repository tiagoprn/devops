help:
	@echo -e "\nHELP:\n"
	@echo -e " make build \n\t Build the container.\n\n"
	@echo -e " make exec \n\t Enter the container.\n\n"
	@echo -e " make rmi \n\tDeletes the current docker images\n\n"

build:
	@echo -e "\nBuilding and tagging the image...\n";
	docker build -t tiagoprn/alpynert:1.0 .
	docker build -t tiagoprn/alpynert:latest .
	@echo -e "\nBuilding and tagging the image...\n";

exec:
	docker exec -it $$(docker ps | grep 'alpynert' | awk '{print $$1}') bash

rmi:
	@echo -e "\nRemoving docker images...[WAIT]\n";
	docker rmi tiagoprn/alpynert:latest
	docker rmi tiagoprn/alpynert:1.0
	@echo -e "\nRemoving docker images...[DONE]\n";

