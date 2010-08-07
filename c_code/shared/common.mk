# common.mk should be included by the platform specific makefiles
.SECONDEXPANSION:

CFLAGS += -Wall -Wextra -O2 -g -std=gnu99
ASFLAGS += --gstabs

vpath %.c ../shared
vpath %.h ../shared
CFLAGS += -I../shared

.PHONY: all
all: $$(TOP_LEVEL_TARGETS)

.PHONY: clean
clean:
	$(RM) *.o $(TOP_LEVEL_TARGETS)
