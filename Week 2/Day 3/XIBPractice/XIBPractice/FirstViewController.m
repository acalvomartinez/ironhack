//
//  FirstViewController.m
//  XIBPractice
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "FirstViewController.h"

#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"First";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonPressed:(UIButton *)sender {
    SecondViewController *secondViewController = [SecondViewController new];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
