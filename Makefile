ENV ?=development
export ENV

build-up:
	docker-compose up -d --build
create-migrate-db: create-db migrate-db
create-db:
	docker-compose run --rm web rails db:create
migrate-db:

	docker-compose run --rm web rails db:migrate RAILS_ENV=$(ENV)
rspec:
	docker-compose run --rm web rspec