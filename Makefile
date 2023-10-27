PROJECT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/sh
.DEFAULT_GOAL := help
compose := docker compose --file $(PROJECT_DIR)/ui.yml
args=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: setup
## Setup development enviroment.
setup:
	$(MAKE) build

.PHONY: start
## Start docker services
start:
	@$(compose) up --detach

.PHONY: cmd
## Run specific command inside ui service
cmd:
	@$(compose) run --rm ui $(args)

.PHONY: stop
## Stop docker services
stop:
	@$(compose) down --rmi all --volumes --remove-orphans

.PHONY: build
## Build all development images
build:
	@$(compose) build

.PHONY: clean
## Clean development images
clean:
	@$(compose) images -q | xargs -r docker rmi

.PHONY: logs
## Log ui container
logs:
	@docker logs -f ui

.PHONY: build-prod
## Build all development images
build-prod:
	@docker compose --file $(PROJECT_DIR)/ui.prod.yml build

.PHONY: restart
## Restart development contains
restart:
	$(MAKE) stop
	$(MAKE) start

.PHONY: help
help:
	@echo "$$(tput setaf 2)Make rules:$$(tput sgr0)";sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## /---/;td" -e"s/:.*//;G;s/\\n## /===/;s/\\n//g;p;}" ${MAKEFILE_LIST}|awk -F === -v n=$$(tput cols) -v i=4 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"- %s%s%s\n",a,$$1,z;m=split($$2,w,"---");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;}printf"%*s%s\n",-i," ",w[j];}}'
