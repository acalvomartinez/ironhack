//
//  RootViewController.m
//  StoryboardPractice
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "RootViewController.h"

#import "PresenterViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PresenterViewController class]]) {
        PresenterViewController *nextViewController = segue.destinationViewController;
        nextViewController.controllerColor = [UIColor purpleColor];
    }
}

@end
