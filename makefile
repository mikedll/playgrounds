
OBJS = main.o TodoList.o Rectangle.o Square.o Fb.o Fa.o CoreDataDemo.o
FLAGS = -g -c

MOMC = /Applications/Xcode.app/Contents/Developer/usr/bin/momc
MOMC_OPTS = -XD_MOMC_SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.0.sdk -XD_MOMC_IOS_TARGET_VERSION=6.0  -MOMC_PLATFORMS iphonesimulator  -MOMC_PLATFORMS iphoneos  -XD_MOMC_TARGET_VERSION=10.6  

all: runmain

runmain: main datamodel
	./main

SRC = $(wildcard *.m)
OBJ = $(SRC:.m=.o)

#
# Gotcha: momc requires absolute path of output .mom file
#
coreDataDemo.mom: coreDataDemo.xcdatamodeld/1.xcdatamodel/contents
	$(MOMC) $(MOMC_OPTS) coreDataDemo.xcdatamodeld $(PWD)/$@

main: $(OBJS)
	gcc -framework Foundation -framework CoreData $(OBJS) -o main

main.o: $(SRC)
	gcc $(FLAGS) main.m

%.o: %.m %.h
	gcc $(FLAGS) $< -o $@

clean:
	rm -rf *.o main coreDataDemo.mom


