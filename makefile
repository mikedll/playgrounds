
OBJS = Main.o TodoList.o Rectangle.o Square.o Fb.o Fa.o

all: main

main: main.o $(OBJS)
	gcc -framework Foundation $(OBJS) -o main
	./main

Fa.o: Fa.h Fa.m Fb.h 
	gcc -c Fa.m

Fb.o: Fb.h Fb.m Fa.h 
	gcc -c Fb.m

main.o: main.m TodoList.h Rectangle.h Square.h Fb.h Fa.h
	gcc -c main.m

TodoList.o: TodoList.h TodoList.m
	gcc -c TodoList.m

Rectangle.o: Rectangle.h Rectangle.m
	gcc -c Rectangle.m

Square.o: Square.h Square.m
	gcc -c Square.m

clean:
	rm -rf *.o main

