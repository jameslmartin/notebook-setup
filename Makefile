.PHONY: help nbserver
.DEFAULT_GOAL := help

APP_NAME=notebooks
APP_PORT=8000
DOCKER_CONTAINER_NAME=$(APP_NAME)

help:
	#source:http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


run-docker:
	@-docker rm -f $(DOCKER_CONTAINER_NAME)
	@docker run --rm \
		$(DOCKER_OPTS) \
		$(DOCKER_PORTS) \
		--name=$(DOCKER_CONTAINER_NAME) \
		--volume `pwd`:/home/jovyan/work \
		--workdir /home/jovyan/work \
		$(DOCKER_IMAGE) $(DOCKER_CMD)

dev: DOCKER_OPTS=-it
dev: DOCKER_PORTS=-p 8888:8888
dev: DOCKER_IMAGE=art-notebook:latest
dev: run-docker

build-art:
	docker build -t art-notebook .
