CC = gcc
CPPFLAGS = -Iinclude
CFLAGS = -Wall -Wextra -O2

all: build/prog

build/prog: build/main.o build/add.o build/sub.o build/util/stats.o
	$(CC) $(CPPFLAGS) $(CFLAGS) build/main.o build/add.o build/sub.o build/util/stats.o -o build/prog

build/main.o: src/main.c
	mkdir -p build
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/main.c -o build/main.o

build/add.o: src/add.c
	mkdir -p build
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/add.c -o build/add.o

build/sub.o: src/sub.c
	mkdir -p build
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/sub.c -o build/sub.o

build/util/stats.o: src/util/stats.c
	mkdir -p build/util
	$(CC) $(CPPFLAGS) $(CFLAGS) -c src/util/stats.c -o build/util/stats.o

clean:
	rm -rf build
