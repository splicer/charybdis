# common.mk should be included by the platform specific makefiles
.SECONDEXPANSION:

CFLAGS = -Wall -Wextra -O2 -g -std=gnu99
ASFLAGS = --gstabs

vpath %.c ../common
vpath %.h ../common
CFLAGS += -I../common

.PHONY: all
all: $(PRIMARY_TARGET)

.PHONY: clean
clean:
	$(RM) *.o $(PRIMARY_TARGET)

$(PRIMARY_TARGET): $$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
