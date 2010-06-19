

#import "TodoList.h"
#import "assert.h"

static NSInteger classStaticVariable;

@implementation TodoList

@synthesize size;

+ (NSInteger)classMethodStaticVar {
  return classStaticVariable++;
}

- (void)doIsa {
  assert( isa == [TodoList class] );
}

- (void)showSize {
  fprintf(stderr, "My title is: %f\n", size);
}

- (void)initSize {
  size = 10.5;
}

@end
