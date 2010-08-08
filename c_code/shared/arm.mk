.SECONDEXPANSION:

CC = arm-linux-gnueabi-gcc
AS = arm-linux-gnueabi-as
LDFLAGS = -static
CFLAGS += -DUSING_ARM
USING_ARM = yes

test.elf: $$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
