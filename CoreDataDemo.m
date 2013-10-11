
#import "CoreDataDemo.h"

@implementation Event
@dynamic fullName;
@end

@implementation CoreDataDemo

-(void) run
{
  NSFileManager* fileManager = [NSFileManager defaultManager];


  if( [fileManager fileExistsAtPath:@"./db.sqlite.fake"] == YES) {
    NSLog(@"Able to locate a fake sqlite file successfully.");
  }
  else {
    NSLog(@"Unable to locate fake local file. Something is probably wrong with this repo or code.");
    return;
  }

  NSURL* modelUrl = [NSURL fileURLWithPath:@"./CoreDataDemo.momd"];
  NSManagedObjectModel* managedObjectModel = [NSManagedObjectModel initWithContentsOfURL:modelUrl];
  NSPersistentStoreCoordinator* persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel managedObjectModel];
}

@end

