
#import <Foundation/Foundation.h>

@interface TodoList : NSObject {
  TodoList *yesterday;
  float size;
}

@property float size;
@property (nonatomic, retain) TodoList* yesterday;

- (id)init;

+ (NSInteger)classMethodStaticVar;

- (void)doIsa;

- (void)copyYesterdayToToday;

@end
