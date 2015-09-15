//
//  FirstViewController.m
//  NavigationControllerPractice
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Next" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button addTarget:self action:@selector(presentNextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.title = @"First";
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)presentNextViewController {
    SecondViewController *nextVC = [SecondViewController new];
    
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end
