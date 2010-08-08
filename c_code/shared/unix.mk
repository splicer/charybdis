.SECONDEXPANSION:

CC = gcc
AS = as

test: $$(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
