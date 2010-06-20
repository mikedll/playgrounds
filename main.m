
#import <Foundation/Foundation.h>


#import "Rectangle.h"
#import "Square.h"
#import "TodoList.h"

#import "assert.h"



// Fail: Use import instead - it prevents double includes on its own.
// #include "Includable.h"
// #include "Includable.h"
#import "Includable.h"
#import "Includable.h"
#import "Includable.h"



void nslog() {
  fprintf(stderr, "Demonstration of NSLog. It prints to STDERR:\n");
  NSLog (@"NSLog output as it prints to %s\n", "STDERR");
}

void allocInitsToZero() {
  TodoList* tl = [TodoList alloc];
  assert ( tl.size == 0);
}

void testClassMembershipAndEquality() {
  TodoList* myList = [TodoList alloc];

  [myList doIsa];

  assert ( [myList class] == [TodoList class] );
  assert ( [myList isKindOfClass: [TodoList class]] );
  assert ( [myList isMemberOfClass: [TodoList class]] );

  assert ( [myList isKindOfClass: [NSObject class]] );
  assert ( ! [myList isMemberOfClass: [NSObject class]] );
  
  id classAsId = [myList class];
  Class classAsClass = [myList class];
  assert ( classAsId == classAsClass );
  assert ( classAsClass == [TodoList class]);  

  TodoList* anotherList = [TodoList alloc];
  assert( [myList class] == [anotherList class] );
}

void instantiateObjects() {
  TodoList* todoList1 = [TodoList alloc];  
  [todoList1 showSize];  

  TodoList* todoList2 = [TodoList alloc];
  [todoList2 initSize];
  [todoList2 showSize];

  // [todoList1 release];
  // [todoList2 release];
}

void versionOfClass() {
  int version = [TodoList version];
  NSLog(@"version of class %d\n", version);
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

void idCanPointToAnyObject() {
  Rectangle* rect = [Rectangle alloc];
  Square* square = [Square alloc];
  id rectAsId = rect;
  id squareAsId = square;
  assert( square == squareAsId );
  assert( rect == rectAsId );
}

void stringTypes() {
  id s = @"some string";
  assert( [s isKindOfClass: [NSString class]] );
}

void classFromString() {
  id mysteryObject = [Rectangle alloc];


  NSString* classOfMysteryObject = [NSString alloc];
  classOfMysteryObject = @"Rectangle";

  assert( [mysteryObject isKindOfClass: NSClassFromString(classOfMysteryObject) ] );
}

@interface CartesianPoint : NSObject {
  float x;
  float y;
}

-(id) setX: (float)x y:(float)y;
@end

@implementation CartesianPoint
-(id) setX: (float)ax y:(float)ay {
  x = ax;
  y = ay;
  return self;
}
@end
void inplaceClassDefinition() {
  CartesianPoint *c = [[CartesianPoint alloc] init];
  id cAgain = [c setX:(1.0) y:(2.0)];
  assert( cAgain == c );
}


@interface C : NSObject {}
-(float) combineTwo:(float)l second:(float)r;
-(float) combineTwo:(float)l Second:(float)r;
@end

@implementation C
-(float) combineTwo:(float)l second:(float)r {
  return l + r;
}
-(float) combineTwo:(float)l Second:(float)r {
  return l * r;
}

@end
void methodArgsCaseSensitive() {
  id c = [C new];

  // Fail:
  // warning: no '-combineTwo:sEcond:' method found
  // assert( 3.0 == [c combineTwo:1.0 sEcond:2.0] );

  assert( 3.0 == [c combineTwo:1.0 second:2.0] );
  assert( 2.0 == [c combineTwo:1.0 Second:2.0] );
}

@interface D : NSObject {}
-(float) reduce:group, ...;
@end

@implementation D
-(float) reduce:group, ... {
  return 1.0;
}

@end

void variableArguments() {
  D *d = [[D alloc] init];
  [d reduce:2.0, 3.0 ];
}

// #import <objc/Object.h>
// @interface A : Object {} @end
// @implementation A @end
// void nsObjectIsntObjectiveC() {
//   // why doesn't this work?
//   // A *a = [A new];
// }

#import "Fa.h"
#import "Fb.h"
void mutuallyDependentInterfaceFiles() {
  Fa *fa = [[Fa alloc] init];
  Fb *fb = [[Fb alloc] init];

  [fa setFb:fb];
}

void variableArgLists

int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  nslog();
  allocInitsToZero();
  instantiateObjects();
  testClassMembershipAndEquality();
  versionOfClass();
  unrecognizedSelector();
  staticClassVar();
  inheritanceAndOverriding();
  classInitialization();
  idCanPointToAnyObject();
  classFromString();
  stringTypes();
  
  


  inplaceClassDefinition();
  methodArgsCaseSensitive();
  variableArguments();
  mutuallyDependentInterfaceFiles();
  variableArgLists();

  //nsObjectIsntObjectiveC();
  
  [pool drain];
  return 0;
}
