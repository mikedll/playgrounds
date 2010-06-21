

#import "TodoList.h"
#import "assert.h"

static NSInteger classStaticVariable;

@implementation TodoList

@synthesize size, yesterday;

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

-(void)copyYesterdayToToday {
  if( yesterday ) {
    size = yesterday->size;
  }
}

@end
