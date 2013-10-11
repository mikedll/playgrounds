
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

void allocInitNewAndProperties() {
  TodoList* todoList1 = [TodoList alloc];
  assert( todoList1.size == 0 );
  [todoList1 init];
  assert( todoList1.size == 1.0 );

  TodoList* todoList2 = [[TodoList alloc] init];
  assert(todoList2.size == 1.0);

  TodoList *todoList3 = [TodoList new];
  assert( todoList3.size == 1.0 );
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

void structurePointer() {
  TodoList *t1 = [[TodoList alloc] init];
  TodoList *dayBeforet1 = [[TodoList alloc] init];
  
  [dayBeforet1 setSize: 3.0];
  [t1 setYesterday: dayBeforet1];
  assert( 1.0 == [t1 size] );
  [t1 copyYesterdayToToday];
  assert( 3.0 == [t1 size] );
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

void dictionaries() {
  NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys: @"v1", @"k1", @"v2", @"k2", nil];

  [dict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
      NSLog(@"%@ = %@", key, obj);
  }];
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

#import "Fa.h"
#import "Fb.h"
void mutuallyDependentInterfaceFiles() {
  Fa *fa = [[Fa alloc] init];
  Fb *fb = [[Fb alloc] init];

  [fa setFb:fb];
}


@interface G : NSObject {
  NSInteger g0;
@private
  NSInteger g1;
@protected
  NSInteger g2;
@public
  NSInteger g3;
}
-(void)incrementAll;
@end

@implementation G

-(void) incrementAll {
  g0++;
  g1++;
  g2++;
  g3++;
}
@end

@interface GSubclass : G {} @end;
@implementation GSubclass
-(void)incrementAll {
  g0++;
  // Fail: g1++; instance variable ‘g1’ is declared private
  g2++;
  g3++;
}
@end

@interface GContainer : NSObject {
  G* g;
}
-(id)init;
-(void)incrementAll;
@end

@implementation GContainer
-(id)init {
  g = [[G alloc] init];
}
-(void)incrementAll {
  // Fail: g->g0++; instance variable ‘g0’ is declared protected
  // Fail: g->g0++; instance variable ‘g1’ is declared private
  // Fail: g->g1++; instance variable ‘g1’ is declared private
  // Fail: g->g2++; instance variable ‘g2’ is declared protected
  g->g3++;
}
@end

instanceVariableVisibility() {
  G* g = [[G alloc] init];
  [g incrementAll];

  G* gSubclass = [[GSubclass alloc] init];
  [gSubclass incrementAll];

  GContainer* gContainer = [[GContainer alloc] init];
  [gContainer incrementAll];

  // Public vars are accessible outside the class
  g->g3++;
}


/*
  1defining a class
    self/super: low/mid/high
    calling init of superclass, first



  2allocating and initialize objects

    from class methods:
    
    newInstance = [[self alloc] init] // inheritance-friendly
    fail: self = [[ClassName alloc] init]

    init: it can return nil, which is why

    dangerous (recall and talk about why)
      a = A alloc
      a init
      a doSomething

  3protocols

    for when you want to declare an interface that CLIENTs
    must use. honestly I don't see the point when you can just
    declare your own interface and be done with it...lots of cerimony
    for nothing.



    // Formal protocol
    @protocol MyProtocol
      -(void) req
    @optional
      -(void) optional
    @required
      -(void) required again
    @end

    // Informal protocol declared as a category. appears to be the only
    // way to declare such a protocol
    @interface NSObject ( MyCategory )
      -(void) optionalMethod
      -(void) optionalMethod
    @end


    // instantiate a protocol object
    id obj = @protocol( MyProtocol )


    @protocol P1 { -(void) m1; }
    @protocol P2 { -(void) m2; }
    @interface ConformsToP1AndP2 : NSObject < P1, P2 > {}
    // no need to redeclare m1 and m2, just implement them.


    id obj = ...
    [obj conformsToProtocol:@protocol(MyProtocol)]
    // less code than many respondsToSelector; similar to
    // isKindOfClass.
    // class object also works with comformsToProtocol

    static types on protocols, for type checks
    id <Protocol1> obj1; // static protocol type checks on obj
    MyClass obj2; // static class type checks on obj
    MyClass <Protocol> obj3; // both


    // protocols can be nested.
    @protocol Protocol1 < Protocol2 > { ...

    id <Protocol1 > obj; // obj also conforms to Protocol2; check with conformsToProtocol

    can get tricky

    @protocol BProtocol { ...
    @protocol AProtocol < BProtocol > { ...

    class B : NSObject  < BProtocol > {...
    class A : B < AProtocol >
    class C : NSObject < AProtocol > { ...

    does B need to implement methods in the BProtocol? Yes
    does A need to implement methods in the B protocol? no. it'll inherit
    B's implementation of ten

    does C need to implement methods in the B protocol?
      A includes the B protocol, so any class that adopts
      A must have an implementation for B.
      C implements A.
      C must have an implementation for B.
      C doesn't have one. so, its implementation must implement the B methods.

    note: respondsToProtocol can be met without formally declaring conformance

    // can forward-declare protocols in the event of circular imports


    // "real example": comformance to teh NSCopying protocol
    @interface I : NSObject < NSCopying > {
     // demonstrate con

  4declared properties

    @interface H {
      float value;
      BOOL fake;
    }

    @property (attr, [, attr] ) float value;
    // -(float)value;
    // -(void)setValueg:(float)newValue

    @property (getter=isFake) BOOL fake;


    @synthesize myProp=instanceVarName


    @synthesize accompanies things in the implementation
    readwrite(default), readonly
    assign (simple assignment; acts like you dont own the obj)
      vs retain (as if you're in charge of this object; calls release
        on previous, and calls retain on incoming))

	  is retain like ++referenceCount ?
	  and release like --referenceCount ?
        
      vs copy (deep copy)
        calls copy
        prev value is sent release

      must talk about memory programming
        
    atomic (default and not declared; requests the _internal lock) vs nonatomic (doesn't request locks)

    __weak
    __strong?

    is the instance variable required to exist? will synthesize
    create it? (after all, we declared properties here...)

    is @dynamic required if you implement the get/setter methods anyway?
    why bother? os @dynamic mutually exclusive with @synthesize?
    it appears that @dynamic is the default value for a property.

    you CAN @synthesize, but override, a setter, as in the case
    of storing a mutableArray that will return an immutable as a copy

    must redeclare propertiy attributes in whole EXCEPT readonly and readwrite

    dealloc:
      you can call release on the property, or,
      on a modern runtime, you cannot access the variable
      directly, so you cannot call release. the setter will call
      release on the old variable. so, you can assign
      nil, and depend on the synthesized setter
      to call release for you.

  5categories and extensions
  6associative references
  7fast eNUMBeration
  8enablind static behavior
  9selectors
  0exception handling
  1threading
  2remote messaging
  3using c++ with objctive C
  appendx A: language summary
  revision history


  Memory Management Programming Guide for Cocoa:
    make an example program the leaks ram on iphone, but not os x.
    and how to avoid.

  The Threading Programming Guide

1
*/


int pointlessRefCountingYouShouldntRelyOn() {
  id obj = [[NSMutableString alloc] init];
  assert( 1 == [obj retainCount] );

  [obj retain];
  [obj release];
  assert( 1 == [obj retainCount] );

  [obj retain];
  assert( 2 == [obj retainCount] );

  [obj release];
  assert( 1 == [obj retainCount] );

  [obj release];
}


int main(int argc, char* argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  nslog();

  // OO and basic ObjC
  inplaceClassDefinition();
  allocInitNewAndProperties();
  idCanPointToAnyObject();
  methodArgsCaseSensitive();
  mutuallyDependentInterfaceFiles();
  staticClassVar();
  classInitialization();
  inheritanceAndOverriding();
  structurePointer();
  instanceVariableVisibility();
  pointlessRefCountingYouShouldntRelyOn();
 
  // "Metaprogramming"
  runtimeTypeInterrogation();
  testClassMembershipAndEquality();
  versionOfClass();

  variadicMethod();

  // Libraries
  strings();
  dictionaries();

  unrecognizedSelector();

  // 
  //nsObjectIsntObjectiveC();
  
  [pool drain];
  return 0;
}
