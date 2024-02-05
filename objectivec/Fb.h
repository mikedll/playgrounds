#import <Foundation/Foundation.h>

#import "Fa.h"

@class Fa;
@interface Fb : NSObject {
  Fa* parent;
}
-(void) setParent:(Fa*)fa;
@end
