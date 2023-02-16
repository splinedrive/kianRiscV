CC = gcc
CFLAGS = -std=c2x -Wall -Wextra -pedantic

all: rv32i

rv32i: rv32i.o
	$(CC) $(CFLAGS) -o rv32i rv32i.o

rv32i.o: rv32i.c
	$(CC) $(CFLAGS) -c rv32i.c

format:
	clang-format -i rv32i.c

clean:
	rm -f rv32i *.o
run: rv32i
	./rv32i

