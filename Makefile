DIRECTORIES=$(shell find . | grep -E "^\./[0-9]/Makefile$$" | cut -f 2 -d "/")

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

all:
	$(foreach DIRECTORY, $(DIRECTORIES), make -C $(DIRECTORY);)

clean:
	$(foreach DIRECTORY, $(DIRECTORIES), make $@ -C $(DIRECTORY);)

clean-env:
	$(SCRIPT_PREFIX)script$(DELIMITER)clean-env$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_CONTAINER)

env:
	$(SCRIPT_PREFIX)script$(DELIMITER)env$(SCRIPT_SUFFIX) $(DOCKER) $(DOCKER_IMAGE) $(DOCKER_IMAGE_TAG) $(DOCKER_CONTAINER)

rebuild:
	$(foreach DIRECTORY, $(DIRECTORIES), make $@ -C $(DIRECTORY);)

rebuild-env: clean-env
	make env

# Only the developer can execute it.
# usage : $ make gitconfig KEY=<GitHub private key path>
gitconfig:
	$(DOCKER) cp $(KEY) $(DOCKER_CONTAINER):/root/SugoiH/ssh/github && \
	$(DOCKER) start $(DOCKER_CONTAINER) && \
	$(DOCKER) exec -it $(DOCKER_CONTAINER) /root/SugoiH/git/gitconfig.sh

.PHONY: clean-env env gitconfig rebuild-env

