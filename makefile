
all: main

main: main.o TodoList.o Rectangle.o Square.o
	gcc -framework Foundation main.o TodoList.o Rectangle.o Square.o -o main

main.o: main.m TodoList.h Rectangle.h Square.h
	gcc -c main.m

TodoList.o: TodoList.h TodoList.m
	gcc -c TodoList.m

Rectangle.o: Rectangle.h Rectangle.m
	gcc -c Rectangle.m

Square.o: Square.h Square.m
	gcc -c Square.m

clean:
	rm -rf *.o main

