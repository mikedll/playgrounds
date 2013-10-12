
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Event : NSManagedObject {
}

@property (nonatomic, retain) NSString* fullName;

@end

@interface CoreDataDemo : NSObject {
}

-(void) run;

-(void) reproduceCantFindModelForSourceStore;

@end
