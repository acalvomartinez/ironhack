//
//  AppDelegate.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "AppDelegate.h"

#import "CoreDataStack.h"
#import "FakeRadarGenerator.h"

#import "RadarsViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) CoreDataStack *cds;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.cds = [[CoreDataStack alloc] initWithDatabaseFilename:@"radars.sqlite"
                                                      andPersistenceType:NSSQLiteStoreType];
    
    //[self fakeRadarGeneratorInContext:self.cds.managedObjectContext];
    
    UINavigationController *nvc = (UINavigationController *)self.window.rootViewController;
    
    RadarsViewController *vc = (RadarsViewController *)nvc.topViewController;
    vc.managedObjectContext = self.cds.managedObjectContext;
    
    return YES;
}

- (void)fakeRadarGeneratorInContext:(NSManagedObjectContext *)context {
    FakeRadarGenerator *fakeGenerator = [[FakeRadarGenerator alloc] init];
    [fakeGenerator genarateRadarsInContext:context];
}

@end
