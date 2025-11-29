#Inception Makefile

# Docker Compose 파일 경로

COMPOSE_FILE = srcs/docker-compose.yml

DATA_PATH = /home/$(USER)/data

all: build up

build :
	@echo "Building Docker images..."
	docker compose -f $(COMPOSE_FILE) build

up :
	@echo "Starting containers..."
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	docker compose -f $(COMPOSE_FILE) up -d

down :
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) down

stop :
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) stop

start :
	@echo "Starting containers..."
	docker compose -f $(COMPOSE_FILE) start

restart : down up

clean : down
	@echo "Removing containers, networks, and images..."
	docker compose -f $(COMPOSE_FILE) down -v --rmi all

fclean : clean
	@echo "Removing volumes..."
	@sudo rm -rf $(DATA_PATH)/wordpress
	@sudo rm -rf $(DATA_PATH)/mariadb
	@docker system prune -af --volumes

re : fclean all

logs :
	docker compose -f $(COMPOSE_FILE) logs -f 

ps :
	docker compose -f $(COMPOSE_FILE) ps

.PHONY : all build up down stop start restart clean fclean re logs ps 