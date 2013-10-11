
OBJS = main.o TodoList.o Rectangle.o Square.o Fb.o Fa.o CoreDataDemo.o
FLAGS = -g -c

all: runmain

runmain: main
	./main

SRC = $(wildcard *.m)
OBJ = $(SRC:.m=.o)

main: $(OBJS)
	gcc -framework Foundation -framework CoreData $(OBJS) -o main

main.o: $(SRC)
	gcc $(FLAGS) main.m

%.o: %.m %.h
	gcc $(FLAGS) $< -o $@

clean:
	rm -rf *.o main

