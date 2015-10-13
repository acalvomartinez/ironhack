//
//  AppDelegate.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "AppDelegate.h"

#import "CoreDataStack.h"

#import "GeoIPsViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) CoreDataStack *cds;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.cds = [[CoreDataStack alloc] initWithDatabaseFilename:@"geoip.sqlite"
                                            andPersistenceType:NSSQLiteStoreType];
    
    UITabBarController *tbvc = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *nvc = [[tbvc viewControllers] firstObject];
    GeoIPsViewController *vc = (GeoIPsViewController *)nvc.topViewController;
    vc.managedObjectContext = self.cds.managedObjectContext;
    
    
    
    return YES;

    
    return YES;
}

@end
