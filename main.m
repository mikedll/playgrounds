
#import <Foundation/Foundation.h>
#import "TodoList.h"

int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  TodoList* todoList1 = [TodoList alloc];
  [todoList1 initSize];
  [todoList1 showSize];

  NSLog (@"hello world");
  [pool drain];
  return 0;
}
