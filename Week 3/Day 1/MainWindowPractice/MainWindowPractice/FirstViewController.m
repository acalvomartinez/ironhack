//
//  FirstViewController.m
//  MainWindowPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubviews];
}

- (void)loadSubviews {
    
    [self addButton1];
    
    [self addLabel1FromRect:self.button1.frame];
    
    [self addView2FromRect:self.label1.frame];
    
}

- (void)addButton1 {
    CGRect frame = CGRectMake(60, 60, 200, 40);
    
    self.button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button1 setTitle:@"Button 1" forState:UIControlStateNormal];
    self.button1.frame = frame;
    
    [self.button1 addTarget:self action:@selector(button1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button1];
}

- (void)addLabel1FromRect:(CGRect)frame {
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, frame.origin.y + frame.size.height + 10, 200, 40)];
    self.label1.text = @"Label 1";
    self.label1.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.label1];
}

- (void)addView2FromRect:(CGRect)frame {
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height + 10, self.view.frame.size.width, 300)];
    
    self.view2.backgroundColor = [UIColor yellowColor];
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button2 setTitle:@"Button 2" forState:UIControlStateNormal];
    self.button2.frame = CGRectMake(0, 10, self.view.frame.size.width, 40);
    
    [self.button2 addTarget:self action:@selector(button2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view2 addSubview:self.button2];
    
    [self addImageView];
    
    [self.view addSubview:self.view2];
}

- (void)addImageView {
    self.imageView = [[UIImageView alloc]initWithFrame: CGRectMake(50, 50, 200, 200)];
    self.imageView.image = [UIImage imageNamed:@"vader"];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view2 addSubview:self.imageView];
}

- (void)button1Pressed:(UIButton *)button {
    UIView *parent = button.superview;
    
    if ([parent.subviews count]>1) {
        [self removeSiblingsOfView:button];
    } else {
        [self addLabel1FromRect:self.button1.frame];
        [self addView2FromRect:self.label1.frame];
    }
}

- (void)button2Pressed:(UIButton *)button {
    UIView *parent = button.superview;
    
    if ([parent.subviews count]>1) {
        [self removeSiblingsOfView:button];
    } else {
        [self addImageView];
    }
}

- (void)removeSiblingsOfView:(UIView*)view {
    UIView *parent = view.superview;
    
    for (UIView *sibling in parent.subviews) {
        if (![sibling isEqual:view]) {
            [sibling removeFromSuperview];
        }
    }
}



@end
