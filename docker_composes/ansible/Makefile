help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the container.\n"
	@echo -e "make version \n\t Show ansible version.\n"
	@echo -e "make kill \n\t KILL the ansible container.\n"
	@echo -e "make exec \n\t Enter the ansible container.\n"

up:
	@docker-compose up -d

version:
	@docker exec -t $$(docker ps | grep ansible | awk '{print $$1}') ansible --version

kill:
	@docker kill $$(docker ps | grep ansible | awk '{print $$1}')

bash:
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') bash
