//
//  ViewController.m
//  MyFirstApp
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak,nonatomic) UISegmentedControl *test;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"From Storyboard");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self doThings];
}

- (void)doThings {
    self.doThingsExecuted = YES;
    NSLog(@"Done!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTap:(id)sender {
    NSLog(@"Done, Yo!");
}

@end
