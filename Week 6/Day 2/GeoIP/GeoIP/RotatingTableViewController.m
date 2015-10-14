//
//  RotatingTableViewController.m
//  GeoIP
//
//  Created by Toni on 14/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RotatingTableViewController.h"

@interface RotatingTableViewController ()

@end

@implementation RotatingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskAll);
}

@end
