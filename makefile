CC = arm-linux-gnueabi-gcc
CFLAGS = -Wall -Wextra -O2 -g -std=gnu99
AS = arm-linux-gnueabi-as
ASFLAGS = --gstabs

.PHONY: all
all: test.elf

test.elf: main.o
	$(CC) -o $@ $^

main.o: main.c

.PHONY: clean
clean:
	$(RM) *.o *.elf
