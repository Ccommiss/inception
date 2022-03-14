### THIS IST THE VERSION WITH docker-compose

# Build the container
build: 
	docker-compose -f srcs/docker-compose.yml build 

# Build and run the container
up:	build 
	docker-compose -f srcs/docker-compose.yml up 

stop:
	docker-compose -f srcs/docker-compose.yml down 

rm: stop
	docker-compose -f srcs/docker-compose.yml rm 

clean-data:
	sudo rm -rf /home/ccommiss/data/wp-files/*
	sudo rm -rf /home/ccommiss/data/wp-db/*

