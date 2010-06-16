
#import <Foundation/Foundation.h>
#import "TodoList.h"
#import "assert.h"

void nslog() {
  NSLog (@"NSLog prints to %s\n", "STDERR");
  fprintf(stderr, "kind of like this.\n");
}

void classInstances() {
  NSLog(@"Allocating instances of classes\n");
  TodoList* todoList1 = [TodoList alloc];
  [todoList1 showSize];  

  TodoList* todoList2 = [TodoList alloc];
  [todoList2 initSize];
  [todoList2 showSize];


  TodoList* myList = [TodoList alloc];

  assert ( YES == [myList isKindOfClass: [NSObject class]]);
  assert ( NO ==  [myList isMemberOfClass: [NSObject class]]);
  assert ( [myList class] == [TodoList class] );
  
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

int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  nslog();
  classInstances();
  unrecognizedSelector();
  
  [pool drain];
  return 0;
}
