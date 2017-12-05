help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the container.\n"
	@echo -e "make centos-version \n\t Show centos version.\n"
	@echo -e "make version \n\t Show ansible version.\n"
	@echo -e "make rm \n\t STOP and DELETE the ansible container.\n"
	@echo -e "make bash \n\t Enter the ansible container.\n"
	@echo -e "make ping \n\t Check ansible host which you will run playbooks is responding.\n"
	@echo -e "make play playbook=[playbook-path] \n\t Run a playbook (e.g. make play playbook=provision-centos7/main.yml). \n"

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

ping: 
	@docker exec -it $$(docker ps | grep ansible | awk '{print $$1}') ansible -i /etc/ansible/hosts all -m ping

play:
	docker exec -it $$(docker ps | grep ansible | awk '{print $$1}')  ansible-playbook -vv /etc/ansible/playbooks/$(playbook) 


