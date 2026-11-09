CC = gcc
CPPFLAGS = -Iinclude
CFLAGS = -Wall -Wextra -O2 -MMD -MP

TARGET = build/prog
SRCS = $(shell find src -name "*.c")
OBJS = $(SRCS:src/%.c=build/%.o)
DEPS = $(OBJS:.o=.d)
OBJ_DIRS = $(sort $(dir $(OBJS)))

.PHONY: all clean test

all: $(TARGET)

$(TARGET): $(OBJS) | build/
	$(CC) $(CPPFLAGS) $(CFLAGS) $(OBJS) -o $@

build/%.o: src/%.c | $(OBJ_DIRS)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_DIRS):
	mkdir -p $@

clean:
	rm -rf build

-include $(DEPS)
