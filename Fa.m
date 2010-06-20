#import "Fa.h"

@implementation Fa
-(void) setFb:(Fb*)fb {
  [fb setParent:self];
  myFb = fb;
}
@end
