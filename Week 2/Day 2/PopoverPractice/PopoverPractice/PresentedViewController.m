//
//  PresentedViewController.m
//  PopoverPractice
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *dissmisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dissmisButton.titleLabel.text = @"Close";
    dissmisButton.frame = CGRectMake(20, 20, 120, 40);
    
    [self.view addSubview:dissmisButton];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
}


@end
