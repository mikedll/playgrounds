

#import "TodoList.h"
#import "assert.h"

static NSInteger classStaticVariable;

@implementation TodoList

@synthesize size;

+ (NSInteger)classMethodStaticVar {
  return classStaticVariable++;
}

- (id)init {
  size = 1.0;
  return self;
}
- (void)doIsa {
  Class classObj = [TodoList class];
  assert( isa == classObj );
}

@end
