### THIS IST THE VERSION WITH docker-compose

# import config.
# You can change the default config with `make cnf="config_special.env" build`


# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`

# grep the version from the mix file
# DOCKER TASKS

# Build the container
build: ## Build the release and develoment container. The development
	docker-compose -f srcs/docker-compose.yml build 

# Build and run the container
up:	build ## Spin up the project
	docker-compose -f srcs/docker-compose.yml up 

stop: ## Stop running containers
	docker-compose -f srcs/docker-compose.yml down 

rm: stop ## Stop and remove running containers
	docker-compose -f srcs/docker-compose.yml rm 

clean-data: ## Clean the generated/compiles files
	sudo rm -rf /home/ccommiss/data/wp-files/*
	sudo rm -rf /home/ccommiss/data/wp-db/*

