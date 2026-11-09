CC = gcc
CPPFLAGS = -Iinclude
CFLAGS = -Wall -Wextra -O2 -MMD -MP

TARGET = build/prog
GEN_BIN = build/genmul

SRCS_TEMP = $(filter-out tools/genmul.c, $(shell find src tools -name "*.c" 2>/dev/null))
SRCS = $(sort $(SRCS_TEMP) src/mul.c)

OBJS = $(SRCS:src/%.c=build/%.o)
DEPS = $(OBJS:.o=.d)
OBJ_DIRS = $(sort $(dir $(OBJS)))

.PHONY: all clean test

all: $(TARGET)

$(TARGET): $(OBJS) | build/
	$(CC) $(CPPFLAGS) $(CFLAGS) $(OBJS) -o $@

build/%.o: src/%.c | $(OBJ_DIRS)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(GEN_BIN): tools/genmul.c | build/
	$(CC) $(CPPFLAGS) $(CFLAGS) $< -o $@

src/mul.c include/mul.h &: $(GEN_BIN)
	./$(GEN_BIN)

build/mul.o: src/mul.c include/mul.h

$(OBJ_DIRS):
	mkdir -p $@

test: $(TARGET)
	@chmod +x tests/test.sh
	./tests/test.sh

clean:
	rm -rf build src/mul.c include/mul.h

-include $(DEPS)

