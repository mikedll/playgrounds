
#import <Foundation/Foundation.h>

#import "Rectangle.h"
#import "Square.h"
#import "TodoList.h"

#import "assert.h"

void nslog() {
  NSLog (@"NSLog prints to %s\n", "STDERR");
  fprintf(stderr, "kind of like this.\n");
}

void allocAndInit() {
  TodoList* tl = [TodoList alloc];
  assert ( tl.size == 0);
}

void classInstances() {
  NSLog(@"Allocating instances of classes\n");
  TodoList* todoList1 = [TodoList alloc];  
  [todoList1 showSize];  

  TodoList* todoList2 = [TodoList alloc];
  [todoList2 initSize];
  [todoList2 showSize];


  TodoList* myList = [TodoList alloc];
  
  [myList doIsa];

  assert ( [myList class] == [TodoList class] );
  assert ( [myList isKindOfClass: [NSObject class]] );
  assert ( ! [myList isMemberOfClass: [NSObject class]] );
  
  id classAsId = [myList class];
  Class classAsClass = [myList class];
  assert ( classAsId == classAsClass );
  assert ( classAsClass == [TodoList class]);


  int version = [TodoList version];
  NSLog(@"version of class %d\n", version);

  TodoList* tList = [TodoList alloc];

}

void unrecognizedSelector() {
  TodoList* tList = [TodoList alloc];

  // [tList someSelector];

  /*
  2010-06-16 16:54:53.177 main[17597:10b] version of class 0
  2010-06-16 16:54:53.177 main[17597:10b] *** -[TodoList id]: unrecognized selector sent to instance 0x105340
  2010-06-16 16:54:53.177 main[17597:10b] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[TodoList id]: unrecognized selector sent to instance 0x105340'
  2010-06-16 16:54:53.178 main[17597:10b] Stack: (
      2486988779,
      2490527291,
      2487017962,
      2487011308,
      2487011506
  )
  */
  

}

// void classMembership() {
//   NSLog (@"Testing class memberships...");
// 
// }

void staticClassVar() {

  assert( 0 == [TodoList classMethodStaticVar] );
  // Fail: Calling instance method instead of class method
  // TodoList* todoList = [TodoList alloc];
  // assert( 0 == [todoList classMethodStaticVar] );
  
  assert( 1 == [TodoList classMethodStaticVar] );
  assert( 2 == [TodoList classMethodStaticVar] );
  return;
}

// Fail: incomplete link
// gcc -framework Foundation main.o TodoList.o Square.o -o main
// Undefined symbols:
//   "_OBJC_CLASS_$_Rectangle", referenced from:
//       objc-class-ref-to-Rectangle in main.o
// ld: symbol(s) not found
// collect2: ld returned 1 exit status
//
// Similar fail msg:
// 
// Undefined symbols:
//   "_OBJC_CLASS_$_Rectangle", referenced from:
//       _OBJC_CLASS_$_Square in Square.o
//   "_OBJC_METACLASS_$_Rectangle", referenced from:
//       _OBJC_METACLASS_$_Square in Square.o
// ld: symbol(s) not found
// collect2: ld returned 1 exit status
//
// Solution:
//   gcc -framework Foundation main.o TodoList.o Rectangle.o Square.o -o main

void inheritanceAndOverriding() {
  Rectangle* rect = [Rectangle alloc];
  Rectangle* square = [Square alloc];

  assert( [square equalSides] );
  assert( ![rect equalSides] );
}

void classInitialization() {
  Square* square = [Square alloc]; // call Class initialize
  assert( 1 == [Square getInitializedStaticVar] );
}

int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  nslog();
  allocAndInit();
  classInstances();
  unrecognizedSelector();
  staticClassVar();
  inheritanceAndOverriding();
  classInitialization();
  
  [pool drain];
  return 0;
}
