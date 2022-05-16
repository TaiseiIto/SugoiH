SOURCES=$(wildcard *.hs)
TARGETS=$(SOURCES:.hs=)

all: $(TARGETS)

clean:
	rm *.hi *.o

rebuild: clean
	make

$(TARGETS): $(@:=.hs)

%: %.hs
	ghc $^

