//
//  ConversionViewController.m
//  MainWindowPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ConversionViewController.h"

@interface ConversionViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end

@implementation ConversionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //CGRect frame = [self.view2 convertRect:self.label2.frame toView:self.view1];
    
    //NSLog(@"Frame: %@", NSStringFromCGRect(self.label2.frame));
    //NSLog(@"Frame to View1: %@", NSStringFromCGRect(frame));
    
    //[self addSubviewInsetTo:self.view1 color:[UIColor yellowColor]];
    //[self addSubviewInsetTo:self.view2 color:[UIColor blackColor]];
}

- (void)addSubviewInsetTo:(UIView *)view color:(UIColor *)color {
    
    CGRect frame = CGRectInset(view.frame, 50, 50);
    
    UIView *subview = [[UIView alloc]initWithFrame:frame];
    subview.backgroundColor = color;
    
    [self.view addSubview:subview];
}


@end
