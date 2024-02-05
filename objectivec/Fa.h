#import <Foundation/Foundation.h>

#import "Fb.h"

// Imports provide declaration of messages that an object can respond to.
// It prevents fail: no '-setParent:' method found
// This could go in the implementation file, but we include
// it here to demonstrate another issue, that of circular includes.

// To declare an instance variable of static type, the class declaration is needed.
// Here, it prevents: expected specifier-qualifier-list before 'Fb'

// Both interface files include each other, so we have circular imports.
// Circular imports will not provide class declarations, so you
// have to use @class forward declarations.

// The same technique is being used in Fb.h.

@class Fb;
@interface Fa : NSObject {
  Fb* myFb;
}

-(void) setFb:(Fb*)fb;
@end
