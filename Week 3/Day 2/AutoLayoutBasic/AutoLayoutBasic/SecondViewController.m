//
//  SecondViewController.m
//  AutoLayoutBasic
//
//  Created by Joan Romano on 8/31/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGrayView];
    [self setupBlueView];
    [self setupTextView];
    [self setupRedView];
}

- (void)setupGrayView {
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectZero];
    self.grayView.backgroundColor = [UIColor lightGrayColor];
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.grayView];
    
    NSDictionary *metrics = @{
                              @"viewHeigth": @129,
                              @"topSpace": @10,
                              @"rigthSpace": @16,
                              @"leftSpace": @16
                              };
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-rigthSpace-[grayView]-leftSpace-|" options:0 metrics:metrics views:@{@"grayView":self.grayView}];
    [self.view addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[grayView(==viewHeigth)]" options:0 metrics:metrics views:@{@"grayView":self.grayView}];
    [self.view addConstraints:verticalConstraints];
    
    NSLayoutConstraint *verticalGreaterThanOrEqualTop = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:5];
    [self.view addConstraint:verticalGreaterThanOrEqualTop];
    
    NSLayoutConstraint *verticalEqualTop = [NSLayoutConstraint constraintWithItem:self.grayView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80];
    verticalEqualTop.priority = 750;
    [self.view addConstraint:verticalEqualTop];
    
    
}

- (void)setupBlueView {
    self.blueView = [[UIView alloc] initWithFrame:CGRectZero];
    self.blueView.backgroundColor = [UIColor blueColor];
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.blueView];
    
    
    NSDictionary *metrics = @{
                              @"viewHeigth": @80,
                              @"topSpace": @39,
                              @"rigthSpace": @16,
                              @"leftSpace": @16
                              };
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[blueView(==viewHeigth)]-rigthSpace-|" options:0 metrics:metrics views:@{@"blueView":self.blueView}];
    [self.view addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[grayView]-topSpace-[blueView(==viewHeigth)]" options:0 metrics:metrics views:@{@"blueView":self.blueView, @"grayView":self.grayView}];
    [self.view addConstraints:verticalConstraints];
    
    NSLayoutConstraint *verticalGreaterThanOrEqualBottom = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5];
    verticalGreaterThanOrEqualBottom.priority = 999;
    [self.view addConstraint:verticalGreaterThanOrEqualBottom];
    
    NSLayoutConstraint *verticalEqualBottom = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:185];
    verticalEqualBottom.priority = 751;
    [self.view addConstraint:verticalEqualBottom];
}

- (void)setupTextView {
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.textLabel.text = @"I have some longer text here that I want to wrap onto multiple lines.";
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.numberOfLines = 0;
    [self.view addSubview:self.textLabel];
    
    NSLayoutConstraint *verticalAlignConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:verticalAlignConstraint];
    
    NSDictionary *metrics = @{
                              @"leftSpace": @16,
                              @"separation": @8
                              };
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpace-[textLabel]-separation-[blueView]" options:0 metrics:metrics views:@{@"textLabel":self.textLabel, @"blueView":self.blueView}];
    [self.view addConstraints:horizontalConstraints];
}

- (void)setupRedView {
    
    self.redView = [[UIView alloc] initWithFrame:CGRectZero];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.redView];
    
    NSDictionary *metrics = @{
                              @"viewWidth": @70,
                              @"viewHeigth": @70,
                              @"bottonSpace": @10
                            };
   
    NSLayoutConstraint *redViewVerticalAlignConstraint = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:redViewVerticalAlignConstraint];
    
    NSArray *redViewVHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(==viewWidth)]" options:0 metrics:metrics views:@{@"redView":self.redView}];
    [self.view addConstraints:redViewVHorizontalConstraints];
        
    NSArray *redViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(==viewHeigth)]-bottonSpace-[bottonLayoutGuide]" options:0 metrics:metrics views:@{@"redView":self.redView, @"bottonLayoutGuide":self.bottomLayoutGuide}];
    [self.view addConstraints:redViewVerticalConstraints];
    
}

@end
