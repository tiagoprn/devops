default: up

start:
	docker-compose start

stop:
	docker-compose stop

restart: stop start

up:
	docker-compose up -d
	clear
	@echo -e 'Reach the web application at http://localhost:7555/wisemapping/'
	sleep 10  # This hack is to give some time for the mysql container to be up to run the "install" command below

kill: stop
	docker-compose kill

remove: kill
	yes | docker-compose rm

rebuild: remove
	docker-compose build
	docker-compose up -d

install: up
	docker exec -it wisemapping_app /wisemapping/init-sql.sh
