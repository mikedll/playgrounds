
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
  NSString *costValue = @"$100";
  NSLog(@"******* Example of panic debugging to STDERR");
  NSLog(@"%s: %s", [NSStringFromClass( [costValue class]) UTF8String], [costValue UTF8String]);
  NSLog(@"************************");

  fprintf(stderr, "Demo complete...\n\n\n");
}

void testClassMembershipAndEquality() {
  TodoList* myList = [[TodoList alloc] init];

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

  TodoList* anotherList = [[TodoList alloc] init];
  assert( [myList class] == [anotherList class] );
}

void allocInitAndProperties() {
  TodoList* todoList1 = [TodoList alloc];
  assert( todoList1.size == 0 );

  TodoList* todoList2 = [[TodoList alloc] init];
  assert(todoList2.size == 1.0);
}

void versionOfClass() {
  int version = [TodoList version];
  NSLog(@"version of class %d\n", version);
}

void unrecognizedSelector() {
  TodoList* tList = [[TodoList alloc] init];

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
  // TodoList* todoList = [[TodoList alloc] init];
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
  Rectangle* rect = [[Rectangle alloc] init];
  Rectangle* square = [[Square alloc] init];

  assert( [square equalSides] );
  assert( ![rect equalSides] );
}

void classInitialization() {
  Square* square = [[Square alloc] init]; // call Class initialize
  assert( 1 == [Square getInitializedStaticVar] );
}

void idCanPointToAnyObject() {
  Rectangle* rect = [[Rectangle alloc] init];
  Square* square = [[Square alloc] init];
  id rectAsId = rect;
  id squareAsId = square;
  assert( square == squareAsId );
  assert( rect == rectAsId );
}


void runtimeTypeInterrogation() {
  Rectangle* r1 = [[Rectangle alloc] init];
  Rectangle* r2 = [[Square alloc] init];

  assert( [@"Rectangle" isEqualToString:NSStringFromClass( [r1 class] )] );
  assert( [@"Square" isEqualToString:NSStringFromClass( [r2 class] )] );


  // This is strictly to demonstrate functionality; probably poor style.
  Square* r3 = [[Square alloc] init];
  id mysteryObject = r3;
  NSString *classNameOfMysteryObject = NSStringFromClass( [r3 class] );
  Class classOfMysteryObject = NSClassFromString( classNameOfMysteryObject );

  id anotherMysteryObject = [[classOfMysteryObject alloc] init];
  assert( [anotherMysteryObject isMemberOfClass: [r3 class]] );
}

void strings() {
    NSMutableString *s = [[NSMutableString alloc] init];

    [s appendString:@"The"];
    [s appendString:@" quick " ];
    [s appendString:@"fox" ];
    assert( [s isEqualToString:@"The quick fox"] );

    assert( [s hasPrefix:@"The " ] );
    assert( [s hasSuffix:@"fox"] );

    NSString *toCast = @"as well";
    [s appendFormat:@" can format in UTF8 %s", [toCast UTF8String] ];

    assert( @"The quick fox can format in UTF8 as well" != s );
    assert( [@"The quick fox can format in UTF8 as well" isEqualToString:s] );

    NSString *manipulatable = @"aLpHa";
    assert( [@"ALPHA" isEqualToString: [manipulatable uppercaseString]] );
    assert( [@"alpha" isEqualToString: [manipulatable lowercaseString]] );
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
-(NSString*) combineStrings:(NSString*)first, ...;
@end

@implementation D
-(NSString*) combineStrings:(NSString*)first, ... {
  va_list ap;
  NSString *s = nil;
  NSMutableString *ret;

  ret = [[NSMutableString alloc] initWithString: first];
  va_start( ap, first );
  s = va_arg( ap, NSString* );
  while( s != nil ) {
    [ret appendString:@" "];
    [ret appendString:s];
    s = va_arg( ap, NSString* );
  }
  va_end( ap );

  return ret;
}
@end

void variadicMethod() {
  D *d = [[D alloc] init];

  NSString *s = [d combineStrings:@"Hello", @"World", nil];
  // Fail: *** [main] Segmentation fault
  // NSMutableString *s = [d combineStrings:@"Hello", @"World"];

  assert( [@"Hello World" isEqualToString:s] );  
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

int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  nslog();

  unrecognizedSelector();
  idCanPointToAnyObject();

  runtimeTypeInterrogation();
  classFromString();
  strings();

  variadicMethod();

  inplaceClassDefinition();

  testClassMembershipAndEquality();
  versionOfClass();

  allocInitAndProperties();
  methodArgsCaseSensitive();
  mutuallyDependentInterfaceFiles();
  staticClassVar();
  classInitialization();
  inheritanceAndOverriding();
 

  //nsObjectIsntObjectiveC();
  
  [pool drain];
  return 0;
}
