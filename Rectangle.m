
#import "Rectangle.h"

@implementation Rectangle

static NSInteger staticVarToInitOnce;

+ (void)initialize {

  // without this check, initialize may be called twice.
  // if( [self class] == [Rectangle class]) {
  //   assert( staticVarToInitOnce == 0 );
  //   staticVarToInitOnce++;
  // }
}

+ (NSInteger)getInitializedStaticVar {
  return staticVarToInitOnce;
}

- (BOOL) equalSides { return NO; }

@end
