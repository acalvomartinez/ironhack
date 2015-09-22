//
//  CodeViewController.m
//  Autolayout Practice
//
//  Created by Toni on 22/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:rightView];
    
    NSDictionary *metrics = @{
                              @"leadingSpace": @10,
                              @"trailingSpace": @10,
                              @"topSpace": @10,
                              @"bottomSpace": @10,
                              @"separation": @20
                              };
    
    NSDictionary *views = NSDictionaryOfVariableBindings(leftView, rightView);
   
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leadingSpace-[leftView(==rightView)]-separation-[rightView]-trailingSpace-|" options:0 metrics:metrics views:views];
    [self.view addConstraints:horizontalConstraints];
    
    NSArray *leftViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[leftView]-bottomSpace-|" options:0 metrics:metrics views:views];
    [self.view addConstraints:leftViewVerticalConstraints];
    
    NSArray *rightViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[rightView]-bottomSpace-|" options:0 metrics:metrics views:views];
    [self.view addConstraints:rightViewVerticalConstraints];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
