//
//  RotatingTabBarController.m
//  GeoIP
//
//  Created by Toni on 14/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RotatingTabBarController.h"

@interface RotatingTabBarController ()

@end

@implementation RotatingTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
