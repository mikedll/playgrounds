
#import <Foundation/Foundation.h>

@interface TodoList : NSObject {
  float size;
}

@property float size;

- (id)init;

+ (NSInteger)classMethodStaticVar;

- (void)doIsa;

@end
