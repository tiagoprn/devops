help:
	@echo -e "\nHELP:\n"
	@echo -e "make up \n\t Raises (run) the containers.\n"
	@echo -e "make passwd \n\t Get the initial admin password of the jenkins master.\n"
	@echo -e "make copyscripts \n\t Copy 'example_script.sh' to the container (to test a freestyle project on jenkins).\n"
	@echo -e "make kill \n\t KILL the jenkins-master container.\n"
	@echo -e "make exec \n\t Enter the jenkins-master container.\n"


up:
	docker-compose up -d
	echo -e "Open your browser at http://[DOCKER_HOST]:8080, then:\n\t $ make passwd"
	echo -e "For BLUE OCEAN, open your browser at http://[DOCKER_HOST]:8080/blue, then:\n\t $ make passwd"

passwd:
	docker exec -t $$(docker ps | grep jenkins-ansible2 | awk '{print $$1}') cat /var/jenkins_home/secrets/initialAdminPassword

copyscripts:
	sudo docker cp script_01.sh $$(docker ps | grep jenkins-ansible2 | awk '{print $$1}'):/tmp
	sudo docker cp script_02.sh $$(docker ps | grep jenkins-ansible2 | awk '{print $$1}'):/tmp
	sudo docker cp script_03.sh $$(docker ps | grep jenkins-ansible2 | awk '{print $$1}'):/tmp

kill:
	docker kill jenkins-ansible2

exec:
	docker exec -it $$(docker ps | grep jenkins-ansible2 | awk '{print $$1}') bash
