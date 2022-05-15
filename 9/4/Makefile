SOURCES=$(wildcard *.hs)
TARGETS=$(SOURCES:.hs=.exe)

all: $(TARGETS)

clean:
	del *.exe *.hi *.o

rebuild: clean
	make

$(TARGETS): $(@:.exe=.hs)

%.exe: %.hs
	ghc $^

