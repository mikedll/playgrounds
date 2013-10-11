
#import "CoreDataDemo.h"

@implementation Event
@dynamic fullName;
@end

@implementation CoreDataDemo

-(void) run
{
  NSFileManager* fileManager = [NSFileManager defaultManager];
  if( [fileManager fileExistsAtPath:@"./db.sqlite"] == YES) {
    NSLog(@"This worked.");
  }
  else {
    NSLog(@"Unable to locate local file.");
  }

  NSURL* modelUrl = [NSURL URLFromFilePath:@"./CoreDataDemo.momd"];
  // NSManagedObjectModel* managedObjectModel = [NSManagedObjectModel initWithContentsOfURL:modelUrl];
  // NSPersistentStoreCoordinator* persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel managedObjectModel];
}

@end

