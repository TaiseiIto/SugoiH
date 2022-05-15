DOCKER = docker
DOCKER_IMAGE = sugoih
DOCKER_IMAGE_TAG = latest
DOCKER_CONTAINER = sugoih
DOCKER_SHELL = /bin/bash

ifeq ($(OS), Windows_NT)
BLANK =
DELIMITER = \$(BLANK)
SCRIPT_PREFIX = 
SCRIPT_SUFFIX = .bat
else
DELIMITER = /
SCRIPT_PREFIX = ./
SCRIPT_SUFFIX = .sh
endif

clean-env:
	$(SCRIPT_PREFIX)script$(DELIMITER)clean-env$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_CONTAINER)

env:
	$(SCRIPT_PREFIX)script$(DELIMITER)env$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_IMAGE_TAG) $(DOCKER_CONTAINER)

rebuild-env: clean-env
	make env

# Only the developer can execute it.
# usage : $ make gitconfig KEY=<GitHub private key path>
gitconfig:
	$(DOCKER) cp $(KEY) $(DOCKER_CONTAINER_NAME):/root/SugoiH/ssh/github && \
	make docker-start && \
	$(DOCKER) exec -it $(DOCKER_CONTAINER_NAME) /root/SugoiH/git/gitconfig.sh

.PHONY: clean-env env gitconfig rebuild-env

