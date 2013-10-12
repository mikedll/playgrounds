
#import "assert.h"
#import "CoreDataDemo.h"

@implementation Event
@dynamic fullName;
@end

@implementation CoreDataDemo

-(void) reproduceCantFindModelForSourceStore
{
  NSFileManager* fileManager = [NSFileManager defaultManager];
  NSString* dbName = @"cantFindModelForSourceStoreDb.sqlite";
  NSURL *storeUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"./%@", dbName]];

  NSURL *emptyModelUrl = [NSURL fileURLWithPath:@"./coreDataDemoBlank.mom"];
  NSURL *nonEmptyModelUrl = [NSURL fileURLWithPath:@"./coreDataDemo.mom"];

  NSLog(@"Looking for .mom managed object model in %@", [emptyModelUrl path]);
  NSManagedObjectModel* emptyMom = [[NSManagedObjectModel alloc] initWithContentsOfURL:emptyModelUrl];


  NSError* error;
  NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:emptyMom];


  // Load up empty model and add store with it, thereby creating empty sqlite db
  if([fileManager fileExistsAtPath:[storeUrl path]]) {
    NSLog(@"Existing db at %@. Need to start without it for this test to work.", [storeUrl path]);
    return;
  }
  else if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
    NSLog(@"Failed to create sqlite database.");
  }
  else if([fileManager fileExistsAtPath:[storeUrl path]]) {
    NSLog(@"Successfully created sqlite database with empty schema. Metadata:");

    // Print metadata of store    
    NSDictionary *sourceMetaData = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                                              URL:storeUrl
                                                                                            error:&error];
      if(sourceMetaData) {
        [sourceMetaData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) { 
            NSLog(@"metadata key %@: %@", key, obj); 
          }];
      }
      else {	
        NSLog(@"Unable to locate metadata for sqlite.");
      }

  }
  else {
    NSLog(@"Something went wrong. Call to addPersistenceStoreWithType succeeded, but resulting sqlite database was not found.");
  }

  // Load up non-empty model. re-add the store withno automigrate options
  // Expect "The model used to open the store is incompatible with the one used to create the store"
  NSLog(@"Looking for nonEmpty .mom managed object model in %@", [nonEmptyModelUrl path]);
  NSManagedObjectModel* nonEmptyMom = [[NSManagedObjectModel alloc] initWithContentsOfURL:nonEmptyModelUrl];

  NSPersistentStoreCoordinator *psc2 = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:nonEmptyMom];

  if(![psc2 addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
    NSString* expectedError1 = @"The model used to open the store is incompatible with the one used to create the store";
    NSLog(@"As expected, failed to add persistence store.");
    assert([[[error userInfo] objectForKey:@"reason"] 
             isEqualToString:
               expectedError1]);
    NSLog(@"Got error reason: \"%@\"", expectedError1);

    // Review: check what happens if options are present. See if we get the 2nd type of error.
    // consistently...if so, they can be removed as a cause.
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
                                              [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, 
                                          nil];

  
    
    NSPersistentStoreCoordinator *psc3 = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:nonEmptyMom];
    if(![psc3 addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
      NSLog(@"As expected, failed to add persistence store with auto-migration options.");
      NSLog(@"Error %@, %@", error, [error userInfo]);
      assert([[[error userInfo] objectForKey:@"reason"]
               isEqualToString:
                 @"class"]);
    }
    else {
      NSLog(@"Expected error, but did not get one while automigrating.");
    }
  }
  else {
    NSLog(@"Expected error, but did not get error while adding persistence store of nonblank MOM schema to blank database.");
  }
}

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

  // Load Managed Object Model
  NSURL *modelUrl = [NSURL fileURLWithPath:@"./coreDataDemo.mom"];

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

  NSString* storePath = [storeUrl path];
  if([fileManager fileExistsAtPath:storePath]) {
    NSLog(@"Note that database file already exists at: %@", storePath);
  }
  else {
    NSLog(@"No database yet exists at %@", storePath);
  }

  NSError *error;
  NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
  if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
    NSLog(@"Unable to create sqlite database.");
  }
  else {
    NSLog(@"Successfully opened the sqlite database with the persistent store coordinator.");
  }

  NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
  [moc setPersistentStoreCoordinator:psc];

  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc];
  [request setEntity:entityDescription];
  [request setFetchLimit:100];

  NSArray *events = [moc executeFetchRequest:request error:&error];
  if(!events) {
    NSLog(@"Some error occurred while executing the fetch request.");
    return;
  }

  if([events count] > 0) {
    NSLog(@"Found %d existing object(s) in the store.", [events count]);
    [events enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        NSLog(@"Fetched an object having name=%@ and id=%d", [obj fullName], [obj objectID]);
      }];
  }
  else { 
    NSLog(@"Did not find objects in the store.");
  }

  Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc];
  event.fullName = @"Rick Sanchez";

  if([moc hasChanges]) {
    NSLog(@"Has changed to save, so saving.");
    if([moc save:&error]) {
      NSLog(@"Successfully saved.");
    }
    else {
      NSLog(@"Failed to save on managed object context.");
    }
  }
  else {
    NSLog(@"No changes to save, so not saving.");
  }

  NSLog(@"CoreData Demo complete.");
}

@end

