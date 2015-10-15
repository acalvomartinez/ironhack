//
//  AppDelegate.m
//  MRC
//
//  Created by Toni on 15/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *array = [[NSArray alloc] init];
    [array release];
    
    NSArray *second = [self newArray];
    [second release];
    
    NSArray *third = [self newArrayV2];
    [third release];
    
    NSArray *fourth = [self arrayV3];
    [fourth retain];
    
    [fourth release];
    
    
    return YES;
}

- (NSArray *)newArray {
    NSArray *array = @[@1, @2, @3];
    [array retain];
    
    return array;
}


- (NSArray *)newArrayV2 {
    NSArray *array = [[NSArray alloc] initWithObjects:@1, @2, @3, nil];
    
    return array;
}

- (NSArray *)arrayV3 {
    NSArray *array = [[NSArray alloc] initWithObjects:@1, @2, @3, nil];

    return [array autorelease];
}

@end
