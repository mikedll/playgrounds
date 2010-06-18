
#import "Rectangle.h"


// Fail: Improper way to do inheritance
// @interface Square : Rectangle {
// ...
// @implementation Square {

// Undefined symbols:
//   "_OBJC_CLASS_$_Rectangle", referenced from:
//       _OBJC_CLASS_$_Square in Square.o
//   "_OBJC_METACLASS_$_Rectangle", referenced from:
//       _OBJC_METACLASS_$_Square in Square.o
// ld: symbol(s) not found
// collect2: ld returned 1 exit status


@interface Square {
}

// - (BOOL) equalSides;

@end
