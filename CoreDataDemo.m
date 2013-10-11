
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

  NSURL *modelUrl = [NSURL fileURLWithPath:@"./CoreDataDemo.mom"];

  NSString *urlString = [modelUrl absoluteString];
  NSLog(@"Looking for .mom managed object model at URL: %@", urlString);

  NSManagedObjectModel* mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];

  if(mom) {
    NSLog(@"Loaded managed object model at %@", [modelUrl absoluteString]);
  } else {
    NSLog(@"Failed to load managed object model at %@", [modelUrl absoluteString]);
    return;
  }

  NSURL *storeUrl = [NSURL fileURLWithPath:@"./db.sqlite"];

  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

  if([fileManager fileExistsAtPath:[storeUrl absoluteString]]) {
    NSLog(@"Note that database file already exists at: %@", [storeUrl absoluteString]);
  }
  else {
    NSLog(@"No database yet exists at %@", [storeUrl absoluteString]);
  }

  NSError *error;
  NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
  if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
    NSLog(@"Unable to create sqlite database.");
  }
  else {
    NSLog(@"Successfully opened the sqlite database with the persistent store coordinator.");
  }

}

@end

