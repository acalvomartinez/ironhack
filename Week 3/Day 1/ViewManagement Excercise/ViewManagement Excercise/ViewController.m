//
//  ViewController.m
//  ViewManagement Excercise
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"
#import "MultipleTouchView.h"
#import "DragView.h"

#define degreesToRadias(x) (M_PI * x / 180.0)

@interface ViewController ()
@property (strong, nonatomic) UIView *greenView;
@property (strong, nonatomic) UIView *blueView;

@property (strong, nonatomic) UIView *orangeView;
@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *grayView;

@property (strong, nonatomic) UIView *gray2View;

@property (strong, nonatomic) UIView *blackView;
@property (strong, nonatomic) UIView *orange2View;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self exercise8];
}

- (void)exercise8 {
    DragView *dragView = [[DragView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:dragView];
}

- (void)exercise7 {
    MultipleTouchView *touchView = [[MultipleTouchView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:touchView];
    
}

- (void)exercise6 {
    MyButton *button = [[MyButton alloc]initWithFrame:CGRectMake(20, 50, 100, 60) title:@"My Button" color:[UIColor greenColor]];
    
    button.title = @"Big Button";
    
    button.color = [UIColor yellowColor];
    
    [self.view addSubview:button];
}

- (void)exercise5 {
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(100, 120, 150, 180)];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackView];
    
    
    self.blackView.transform = CGAffineTransformMake(-0.2, 1.5, 1, 0, 0, 0);
    
}
- (void)exrecise4 {
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(50, 120, 150, 180)];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackView];
    
    CGRect frame = CGRectInset(self.blackView.bounds, 10, 10);
    self.orange2View = [[UIView alloc] initWithFrame:frame];
    self.orange2View.backgroundColor = [UIColor orangeColor];
    [self.blackView addSubview:self.orange2View];
    
    self.blackView.transform = CGAffineTransformMakeRotation(degreesToRadias(45));
    self.blackView.transform = CGAffineTransformTranslate(self.blackView.transform, 100, 0);

}

- (void)exercise3 {
    self.gray2View = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    self.gray2View.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.gray2View];
    
    [self createRedView];
    [self createOrangeView];
    
    CGRect frame1 = self.redView.frame;
    CGRect frame2 = self.orangeView.frame;
    
    CGRectDivide(self.gray2View.frame, &frame2, &frame1, 100, CGRectMaxYEdge);
    
    self.redView.frame = frame1;
    self.orangeView.frame = frame2;
}


- (void)excercise2 {
    [self createOrangeView];
    [self createRedView];
    [self createGrayView];
    [self reorderViews];
}

- (void)createRedView {
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 150, 240)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
}

- (void)createOrangeView {
    self.orangeView = [[UIView alloc] initWithFrame:CGRectMake(140, 240, 120, 120)];
    self.orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.orangeView];
}

- (void)createGrayView {
    CGRect unionFrame = CGRectUnion(self.redView.frame, self.orangeView.frame);
    
    self.grayView = [[UIView alloc] initWithFrame:unionFrame];
    self.grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.grayView];
}

- (void)reorderViews {
    [self.view sendSubviewToBack:self.grayView];
}

// Exercise 1

- (void)changeInset {
    self.greenView.frame = CGRectInset(self.blueView.frame, 10, 10);
}

- (void)logCenter:(UIView *)view {
    NSLog(@"center x: %f y: %f",view.center.x, view.center.y);
    NSLog(@"center: %@", NSStringFromCGPoint(view.center));
    
    CGPoint newCenter = [self.blueView convertPoint:self.blueView.center fromView:self.view];
    
     NSLog(@"center: %@", NSStringFromCGPoint(newCenter));
}

@end
