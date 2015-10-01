//
//  AppDelegate.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "AppDelegate.h"

#import "MoviesTableViewController.h"
#import "ShowsTableViewController.h"
#import "ProfileViewController.h"
#import "CoreDataStack.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];

    UITabBarController *tabBarController = (id) self.window.rootViewController;
    UINavigationController *moviesNavigationController = tabBarController.viewControllers.firstObject;
    MoviesTableViewController *moviesViewController = (id)moviesNavigationController.topViewController;
    UINavigationController *showsNavigationController = tabBarController.viewControllers[1];
    ShowsTableViewController *showsViewController = (id)showsNavigationController.topViewController;
    UINavigationController *profileNavigationController = tabBarController.viewControllers.lastObject;
    ProfileViewController *profileViewController = (id)profileNavigationController.topViewController;
    
    moviesViewController.managedObjectContext = coreDataStack.managedObjectContext;
    showsViewController.managedObjectContext = coreDataStack.managedObjectContext;
    profileViewController.managedObjectContext = coreDataStack.managedObjectContext;
    
    NSDate *lastLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastLogin"];
    if (lastLogin) {
        NSLog(@"Last login was on %@",lastLogin);
    }
    
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
