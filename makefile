
all: main

main: main.o TodoList.o
	gcc -framework Foundation main.o TodoList.o -o main

main.o: main.m TodoList.h
	gcc -c main.m

TodoList.o: TodoList.h TodoList.m
	gcc -c TodoList.m

clean:
	rm -rf *.o main

