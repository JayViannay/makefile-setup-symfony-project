# RUN docker-compose for db environment
run-db-from-docker-compose: ## to deploy mysql-server and phpmyadmin
	sudo docker-compose up -d
	
# Create db
create-db:
	php bin/console doctrine:database:create

install-dep:
	composer install

install-webpack:
	npm install
	npm run build

# Update db schema
update-db:
	php bin/console make:migration
	php bin/console doctrine:migrations:migrate --no-interaction

load-fixtures:
	php bin/console doctrine:fixtures:load --no-interaction
# RUN server
run-server:
	symfony server:start
	
run: ## to setup and install all
	make run-db-from-docker-compose create-db install-dep install-webpack update-db load-fixtures run-server