# common.mk should be included by the platform specific makefiles
.SECONDEXPANSION:

vpath %.c ../shared
vpath %.h ../shared
CFLAGS += -I../shared

CFLAGS += -Wall -Wextra -O2 -g -std=gnu99
#ASFLAGS += --gstabs

ifeq ($(PLATFORM), arm)
  CC := arm-linux-gnueabi-gcc
  AS := arm-linux-gnueabi-as
  LDFLAGS += -static
  CFLAGS += -DUSING_ARM
  TOP_LEVEL_TARGETS += test.elf
else
  CC := gcc
  AS := as
  TOP_LEVEL_TARGETS += test
endif

ifeq ($(USE_IO), yes)
  OBJS += main_with_io.o
else
  OBJS += main.o
endif

ifeq ($(IMPLEMENTATION_TYPE), floating_point)
  TOP_LEVEL_TARGETS += rgb2y_floating_point.s
  OBJS += rgb2y_floating_point.o
endif

ifeq ($(IMPLEMENTATION_TYPE), fixed_point)
  TOP_LEVEL_TARGETS += rgb2y_fixed_point.s
  OBJS += rgb2y_fixed_point.o
endif

ifeq ($(IMPLEMENTATION_TYPE), with_hardware)
  TOP_LEVEL_TARGETS += test.elf rgb2y_with_hardware_noops.s rgb2y_with_hardware.s
  OBJS += rgb2y_with_hardware.o
endif

.PHONY: all
all: $$(TOP_LEVEL_TARGETS)

.PHONY: clean
clean:
	$(RM) *.o $(TOP_LEVEL_TARGETS)

rgb2y_%.o: rgb2y_%.c rgb2y.h

rgb2y_%.s: rgb2y_%.c rgb2y.h
	$(CC) -S $< $(CFLAGS) $(ASFLAGS) -o $@

test: $$(OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(OBJS)
