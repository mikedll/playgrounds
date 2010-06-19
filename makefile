
OBJS = Main.o TodoList.o Rectangle.o Square.o

all: main

main: main.o $(OBJS)
	gcc -framework Foundation $(OBJS) -o main
	./main

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

