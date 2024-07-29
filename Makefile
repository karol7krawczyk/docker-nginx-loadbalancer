.PHONY: build up down logs clean

export COMPOSE_PROJECT_NAME := loadbalancer

up:
	@echo "Starting Docker containers..."
	docker compose up -d
	@make -s ps

build:
	@echo "Building Docker images..."
	docker compose build

down:
	@echo "Stopping Docker containers..."
	docker compose down --remove-orphans

logs:
	@echo "Fetching logs from Docker containers..."
	docker compose logs --tail=0 --follow

clean:
	@echo "Removing stopped containers and unused volumes..."
	docker compose down --rmi all --volumes --remove-orphans
	docker system prune -f

restart:
	@make -s down
	@make -s up

stop:
	docker compose stop

ps:
	docker compose ps

benchmark:
	docker compose exec benchmark ab -n 1000 -c 10 http://loadbalancer/
