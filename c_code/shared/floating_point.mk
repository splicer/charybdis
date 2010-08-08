OBJS += rgb2y_floating_point.o
rgb2y_floating_point.o: rgb2y.h

TOP_LEVEL_TARGETS += rgb2y_floating_point.s

ifeq($(USING_ARM), yes)
TOP_LEVEL_TARGETS += test.elf
else
TOP_LEVEL_TARGETS += test
endif
