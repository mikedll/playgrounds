
#import "Rectangle.h"

@implementation Rectangle

static NSInteger staticVarToInitOnce;

+ (void)initialize {
  // without this check, initialize may be called twice.
  if( self == [Rectangle class]) {
    assert( staticVarToInitOnce == 0 );
    staticVarToInitOnce++;
  }
  else {
    NSLog(@"Base class allowed initialized to go to superclass");
  }
}

+ (NSInteger)getInitializedStaticVar {
  return staticVarToInitOnce;
}

- (BOOL) equalSides { return NO; }

@end
