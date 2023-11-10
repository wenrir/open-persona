PROJECT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/sh
.DEFAULT_GOAL := help
compose := docker compose --file $(PROJECT_DIR)/ui.yml
args=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: setup
## Setup development enviroment.
setup:
	@git config --local core.hookPath .githooks
	$(MAKE) build

.PHONY: lint
## Lint code
lint: build
	@$(compose) run --rm ui lint

.PHONY: test
## test code
test:
	@BUILD_TARGET=test_ui $(compose) run --rm ui test

.PHONY: start
## Start docker services
start: build
	@$(compose) up --detach

.PHONY: cmd
## Run specific command inside ui service
cmd: build
	@$(compose) run --rm ui $(args)

.PHONY: stop
## Stop docker services
stop:
	@$(compose) down --rmi all --volumes --remove-orphans

.PHONY: build
## Build development images
build:
	@BUILD_TARGET=base_ui $(compose) build

.PHONY: build-test
## Build test image
build-test:
	@BUILD_TARGET=test_ui $(compose) build

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
