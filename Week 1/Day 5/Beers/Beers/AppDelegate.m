//
//  AppDelegate.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AppDelegate.h"

#import "Beer.h"
#import "Person.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Beer *estrella = [Beer beerWithName:@"Estrella" color:@"Blonde" grade:4];
    Beer *moritz = [Beer beerWithName:@"Moritz" color:@"Red" grade:5];
    
    NSLog(@"%@",estrella);
    NSLog(@"%@",moritz);
    
    Person *diego = [[Person alloc] init];
    diego.name = @"Diego";
    diego.address = @"Avd Ameria 45";
    [diego setAge:20];
    
    Person *pepe = [Person personWithName:@"Pepe" address:@"Paseo de la Habana 4"];
    Person *groucho = [Person personWithName:@"Groucho" address:@"Hill Valley Street"];
    
    NSMutableArray *persons = [NSMutableArray arrayWithArray:@[diego, pepe, groucho]];
    
    for (NSUInteger i=0; i < 100; i++) {
        NSString *personName = [NSString stringWithFormat:@"Person %lu", i];
        [persons addObject:[Person personWithName:personName]];
    }
    
    NSLog(@"%@",persons);
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
