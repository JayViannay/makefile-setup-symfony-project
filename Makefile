# RUN docker-compose for db environment
run-db-from-docker-compose: ## to deploy mysql-server and phpmyadmin
	sudo docker-compose up -d

# Load dependencies
install-dep:
	composer install
	
# Create db
create-db:
	php bin/console doctrine:database:create

# Install webpack
install-webpack:
	npm install
	npm run build

# Update db schema
update-db:
	php bin/console make:migration
	php bin/console doctrine:migrations:migrate --no-interaction

# Load fixtures
load-fixtures:
	php bin/console doctrine:fixtures:load --no-interaction

# RUN server
run-server:
	symfony server:start

# clean-db:
clean-db:
	php bin/console doctrine:database:drop --force
	php bin/console doctrine:database:create
	rm -rf migrations/*.php
	php bin/console make:migration
	php bin/console doctrine:migrations:migrate --no-interaction
	php bin/console doctrine:fixtures:load --no-interaction
	
run: ## to setup and install all
	make run-db-from-docker-compose install-dep create-db install-webpack update-db load-fixtures run-server