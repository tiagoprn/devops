default: up

start:
	docker-compose start

stop:
	docker-compose stop

restart: stop start

up:
	docker-compose up -d
	clear
	@echo -e 'Reach the web application at https://localhost:6443/'
	sleep 10  # This hack is to give some time for the mysql container to be up to run the "install" command below

kill: stop
	docker-compose kill

remove: kill
	yes | docker-compose rm

rebuild: remove
	docker-compose build
	docker-compose up -d

bash: up
	docker exec -it draw-io bash
