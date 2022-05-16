DIRECTORIES=$(shell ls -l | grep ^d | awk '{print $$9}')
SOURCES=$(wildcard *.hs)
TARGETS=$(SOURCES:.hs=)

all: directories $(TARGETS)

clean:
	rm $(TARGETS) *.hi *.o

directories:
	$(foreach DIRECTORY, $(DIRECTORIES), make -C $(DIRECTORY);)

rebuild: clean
	make

$(TARGETS): $(@:=.hs)

%: %.hs
	ghc $^

