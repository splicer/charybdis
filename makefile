CC = arm-linux-gnueabi-gcc
CFLAGS = -Wall -O2 -g
AS = arm-linux-gnueabi-as
ASFLAGS = --gstabs

.PHONY: all
all: test.elf

test.elf: main.o

main.o: main.c

.PHONY: clean
clean:
	$(RM) *.o *.elf
