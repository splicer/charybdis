.SECONDEXPANSION:

CC = gcc
AS = as

TOP_LEVEL_TARGETS += test
test: $$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
