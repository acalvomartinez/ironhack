//
//  ViewController.m
//  DeadlockTest
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"Start");
//    dispatch_queue_t myDispachtQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(myDispachtQueue, ^{
//        NSLog(@"Outside");
//        dispatch_sync(myDispachtQueue, ^{
//            NSLog(@"Inside");
//        });
//    });
//    NSLog(@"End");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Inside");
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
