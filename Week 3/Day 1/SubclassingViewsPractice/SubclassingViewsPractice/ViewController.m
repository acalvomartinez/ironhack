//
//  ViewController.m
//  SubclassingViewsPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomView *customView = [[CustomView alloc]initWithFrame:self.view.frame title:@"Subview"];
    customView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:customView];
    
    customView.title = @"Title";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
