help:
	@echo -e " make bash                               - Run a bash session."

bash:  
	sudo docker exec -it $$(sudo docker ps | grep seafile | awk '{print $$1}') bash

info:
	sudo docker inspect $$(sudo docker ps | grep seafile | awk '{print $$1}')

