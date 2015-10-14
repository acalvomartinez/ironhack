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
#import "GeoIPListMapViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) CoreDataStack *cds;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.cds = [[CoreDataStack alloc] initWithDatabaseFilename:@"geoip.sqlite"
                                            andPersistenceType:NSSQLiteStoreType];
    
    GeoIPsViewController *listViewController= [self listViewController];
    listViewController.managedObjectContext = self.cds.managedObjectContext;

    GeoIPListMapViewController *mapListViewController = [self mapLisViewController];
    mapListViewController.managedObjectContext = self.cds.managedObjectContext;
    
    return YES;
}
                                                               
- (GeoIPsViewController *)listViewController {
    UITabBarController *tbvc = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *nvc = [[tbvc viewControllers] firstObject];
    GeoIPsViewController *vc = (GeoIPsViewController *)nvc.topViewController;

    return vc;
}

- (GeoIPListMapViewController *)mapLisViewController {
    UITabBarController *tbvc = (UITabBarController *)self.window.rootViewController;
    
    GeoIPListMapViewController *vc = (GeoIPListMapViewController *)[[tbvc viewControllers] lastObject];
    vc.title = @"GeoIP Map";
    
    return vc;
}

@end
