//
//  AppDelegate.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "AppDelegate.h"

#import "CoreDataManager.h"
#import "ShowsTableViewController.h"
#import "MoviesTableViewController.h"
#import "UserProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastLoginDate"];
    NSLog(@"LastDate: %@", date);
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    
    UITabBarController *tabBarViewController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *showsNavigation = [tabBarViewController.viewControllers objectAtIndex:0];
    ShowsTableViewController *showsViewController = [showsNavigation.viewControllers firstObject];
    showsViewController.managedContext = coreDataManager.managedObjectContext;
    
    UINavigationController *moviesNavigation = [tabBarViewController.viewControllers objectAtIndex:1];
    MoviesTableViewController *moviesViewController = [moviesNavigation.viewControllers firstObject];
    moviesViewController.managedContext = coreDataManager.managedObjectContext;
    
    UserProfileViewController *userProfileViewController = [tabBarViewController.viewControllers objectAtIndex:2];
    userProfileViewController.managedContext = coreDataManager.managedObjectContext;

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
