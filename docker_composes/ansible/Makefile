help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the container.\n"
	@echo -e "make centos-version \n\t Show centos version.\n"
	@echo -e "make version \n\t Show ansible version.\n"
	@echo -e "make generate-keys \n\t Generate ssh keys for the root user to connect to remote machines.\n"
	@echo -e "make rm \n\t STOP and DELETE the ansible container.\n"
	@echo -e "make bash \n\t Enter the ansible container.\n"

up:
	@docker-compose up -d

centos-version:
	@docker exec -t $$(docker ps | grep ansible | awk '{print $$1}') cat /etc/centos-release

version:
	@docker exec -t $$(docker ps | grep ansible | awk '{print $$1}') ansible --version

generate-keys: 
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') curl https://raw.githubusercontent.com/tiagoprn/bin_public/master/create_ssh_keys.sh -o /opt/create_ssh_keys.sh
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') bash /opt/create_ssh_keys.sh

rm:
	@docker-compose stop && docker-compose rm -f

bash:
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') bash
