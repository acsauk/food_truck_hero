RAILS_ENV ?=development
export RAILS_ENV

build-up:
	docker-compose up -d --build
create-db:
	docker-compose run --rm web rails db:create RAILS_ENV=$(RAILS_ENV)
migrate-db:
	docker-compose run --rm web rails db:migrate RAILS_ENV=$(RAILS_ENV)
rspec:
	docker-compose run --rm web rspec