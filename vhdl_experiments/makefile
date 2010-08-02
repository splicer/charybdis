.PHONY: all
all: hello_world

.PHONY: clean
clean:
	$(RM) *.cf *.o

hello_world: hello_world.o
	ghdl -e $@

hello_world.o: hello_world.vhdl
	ghdl -a $^

