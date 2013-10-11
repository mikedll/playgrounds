
FLAGS = -g -c
MOMC = /Applications/Xcode.app/Contents/Developer/usr/bin/momc

# From XCode. Turns out we don't really need 'em.
# MOMC_OPTS = -XD_MOMC_SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.0.sdk -XD_MOMC_IOS_TARGET_VERSION=6.0  -MOMC_PLATFORMS iphonesimulator  -MOMC_PLATFORMS iphoneos  -XD_MOMC_TARGET_VERSION=10.6  
MOMC_OPTS = 

all: runmain

runmain: main coreDataDemo.mom
	./main

SRC = $(wildcard *.m)
OBJS = $(SRC:.m=.o)
HEADERS = $(filter-out main.h,$(SRC:.m=.h))

#
# Gotcha: momc requires absolute path of output .mom file
#
coreDataDemo.mom: coreDataDemo.xcdatamodeld/1.xcdatamodel/contents
	$(MOMC) $(MOMC_OPTS) coreDataDemo.xcdatamodeld $(PWD)/$@

main: $(OBJS)
	gcc -framework Foundation -framework CoreData $(OBJS) -o main

main.o: main.m $(HEADERS) 
	gcc $(FLAGS) $<

%.o: %.m %.h
	gcc $(FLAGS) $< -o $@

clean:
	rm -rf *.o main coreDataDemo.mom


