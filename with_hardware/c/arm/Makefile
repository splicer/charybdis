CC = arm-linux-gnueabi-gcc
AS = arm-linux-gnueabi-as
LDFLAGS = -static
PRIMARY_TARGET = test.elf

include ../common/common.mk

OBJS += main.o
main.o: main.c rgb2y.h

rgb2y.s: rgb2y.c rgb2y.h
	$(CC) -S $(CFLAGS) $<
