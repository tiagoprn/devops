help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the container.\n"
	@echo -e "make centos-version \n\t Show centos version.\n"
	@echo -e "make version \n\t Show ansible version.\n"
	@echo -e "make rm \n\t STOP and DELETE the ansible container.\n"
	@echo -e "make bash \n\t Enter the ansible container.\n"

up:
	@docker-compose up -d

centos-version:
	@docker exec -t $$(docker ps | grep ansible | awk '{print $$1}') cat /etc/centos-release

version:
	@docker exec -t $$(docker ps | grep ansible | awk '{print $$1}') ansible --version

rm:
	@docker-compose stop && docker-compose rm -f

bash:
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') bash
