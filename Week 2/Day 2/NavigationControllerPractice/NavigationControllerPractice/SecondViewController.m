//
//  SecondViewController.m
//  NavigationControllerPractice
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.title = @"Second";
    
    [self initNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self hideToolBar];
}

- (void)initNavigation {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                               target:self
                                                                               action:@selector(showToolBar)];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)showToolBar {
    
    [self addCancelNavigation];
    
    [self initToolBar];
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}


- (void)initToolBar {
    UIBarButtonItem *buttonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                 target:nil
                                                                                 action:nil];
    UIBarButtonItem *buttonItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                 target:nil
                                                                                 action:nil];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    NSArray *toolBarButtons = @[buttonItem1, itemSpace, buttonItem2];
    
    [self setToolbarItems:toolBarButtons animated:YES];
}

- (void)addCancelNavigation {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(hideToolBar)];
    
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)hideToolBar {
    [self initNavigation];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}


@end
