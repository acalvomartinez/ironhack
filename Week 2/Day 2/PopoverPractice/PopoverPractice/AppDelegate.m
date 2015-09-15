//
//  AppDelegate.m
//  PopoverPractice
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popoverController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController *mainViewController = [UIViewController new];
    mainViewController.view.backgroundColor = [UIColor yellowColor];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                            target:self
                                                                            action:@selector(showPopover:)];
    mainViewController.navigationItem.rightBarButtonItem = button;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mainViewController];
   
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)showPopover:(UIBarButtonItem *)button {
    UIViewController *presentedViewController = [UIViewController new];
    presentedViewController.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *dissmisButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dissmisButton setTitle:@"Close" forState:UIControlStateNormal];
    dissmisButton.frame = CGRectMake(50, 50, 100, 40);
    [dissmisButton addTarget:self action:@selector(dissmisPopover) forControlEvents:UIControlEventTouchUpInside];
    dissmisButton.tintColor = [UIColor whiteColor];
    [presentedViewController.view addSubview:dissmisButton];
    
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:presentedViewController];
    self.popoverController.backgroundColor = presentedViewController.view.backgroundColor;
    self.popoverController.delegate = self;
    [self.popoverController presentPopoverFromBarButtonItem:button
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES];
}

- (void)dissmisPopover {
    [self.popoverController dismissPopoverAnimated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return NO;
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
