help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the container.\n"
	@echo -e "make centos-version \n\t Show centos version.\n"
	@echo -e "make version \n\t Show ansible version.\n"
	@echo -e "make rm \n\t STOP and DELETE the ansible container.\n"
	@echo -e "make bash \n\t Enter the ansible container.\n"
	@echo -e "make ping \n\t Check ansible host which you will run playbooks is responding.\n"
	@echo -e "make play playbook=[playbook-path] \n\t Run a playbook (e.g. make play playbook=provision-centos7/roles/tasks/main.yml). \n"

build:
	@./build-docker-compose-with-env-vars.sh

up: build
	@sudo docker-compose up -d
	@sudo docker exec -t $$(sudo docker ps | grep ansible | awk '{print $$1}') chown -R root.root /root/.ssh

centos-version:
	@sudo docker exec -t $$(sudo docker ps | grep ansible | awk '{print $$1}') cat /etc/centos-release

version:
	@sudo docker exec -t $$(sudo docker ps | grep ansible | awk '{print $$1}') ansible --version

rm:
	@sudo docker-compose stop && sudo docker-compose rm -f

bash:
	@sudo docker exec -it $$(sudo docker ps | grep ansible | awk '{print $$1}') bash

ping: 
	@sudo docker exec -it $$(sudo docker ps | grep ansible | awk '{print $$1}') ansible -i /etc/ansible/hosts all -m ping

play:
	sudo docker exec -it $$(sudo docker ps | grep ansible | awk '{print $$1}')  ansible-playbook -vv /etc/ansible/playbooks/$(playbook) 


