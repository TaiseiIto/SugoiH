DIRECTORIES=$(shell ls -l | grep ^d | awk '{print $$9}')
SOURCES=$(wildcard *.hs)
TARGETS=$(SOURCES:.hs=)

all: $(TARGETS)

clean:
	$(foreach DIRECTORY, $(DIRECTORIES), make $@ -C $(DIRECTORY);)
	rm $(TARGETS) *.hi *.o

directories:
	$(foreach DIRECTORY, $(DIRECTORIES), make -C $(DIRECTORY);)

rebuild: clean
	make

$(TARGETS): directories $(@:=.hs)

%: %.hs
	ghc $^

