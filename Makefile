DOCKER = docker
DOCKER_IMAGE = sugoih
DOCKER_IMAGE_TAG = latest
DOCKER_CONTAINER = sugoih
DOCKER_SHELL = /bin/sh

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

clean-devenv:
	$(SCRIPT_PREFIX)script$(DELIMITER)clean-devenv$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_CONTAINER)

devenv:
	$(SCRIPT_PREFIX)script$(DELIMITER)devenv$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_IMAGE_TAG) $(DOCKER_CONTAINER)

rebuild-devenv: clean-devenv
	make devenv

# Only the developer can execute it.
# usage : $ make gitconfig KEY=<GitHub private key path>
gitconfig:
	$(DOCKER) cp $(KEY) $(DOCKER_CONTAINER_NAME):/root/SugoiH/ssh/github && \
	make docker-start && \
	$(DOCKER) exec -it $(DOCKER_CONTAINER_NAME) /root/SugoiH/git/gitconfig.sh

.PHONY: clean-devenv devenv gitconfig rebuild-devenv

