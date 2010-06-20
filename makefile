
OBJS = Main.o TodoList.o Rectangle.o Square.o Fb.o Fa.o
FLAGS = -g -c

all: main runmain

runmain:
	./main

main: main.o $(OBJS)
	gcc -framework Foundation $(OBJS) -o main

Fa.o: Fa.h Fa.m Fb.h 
	gcc $(FLAGS) Fa.m

Fb.o: Fb.h Fb.m Fa.h 
	gcc $(FLAGS) Fb.m

main.o: main.m TodoList.h Rectangle.h Square.h Fb.h Fa.h
	gcc $(FLAGS) main.m

TodoList.o: TodoList.h TodoList.m
	gcc $(FLAGS) TodoList.m

Rectangle.o: Rectangle.h Rectangle.m
	gcc $(FLAGS) Rectangle.m

Square.o: Square.h Square.m
	gcc $(FLAGS) Square.m

clean:
	rm -rf *.o main

