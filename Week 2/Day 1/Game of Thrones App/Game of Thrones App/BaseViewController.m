//
//  BaseViewController.m
//  Game of Thrones App
//
//  Created by Toni on 14/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "BaseViewController.h"

CGFloat const padding = 8;
CGFloat const margin = 10;
CGFloat const heightUnit = 40;
CGFloat const initialUpperMargin = 40;

@interface BaseViewController ()

@property (nonatomic, assign) CGSize screenSize;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BaseViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenSize = self.view.frame.size;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpScrollViewSize];
}




#pragma mark - Control Positioning

- (void)placeView:(UIView *)bottomView underView:(UIView *)upperWiew withHeightUnits:(CGFloat)heightUnits {
    if (!upperWiew) {
        bottomView.frame = CGRectMake(padding, initialUpperMargin, self.screenSize.width - (padding*2), heightUnits * heightUnit);
    } else {
        bottomView.frame = [self frameUnderFrame:upperWiew.frame withHeightUnits:heightUnits];
    }
    
    [self.scrollView addSubview:bottomView];
}

- (CGRect)frameUnderFrame:(CGRect)sourceFrame withHeightUnits:(CGFloat)heightUnits {
    CGFloat y = sourceFrame.origin.y + sourceFrame.size.height + margin;
    return CGRectMake(padding, y, self.screenSize.width - (padding*2), heightUnit * heightUnits);
}

#pragma mark - ScrollView Methods

- (void) setUpScrollViewSize {
    
    UIView *lastView = [[self.scrollView subviews] lastObject];
    
    CGSize contentSize = CGSizeMake(self.screenSize.width, lastView.frame.origin.y + lastView.frame.size.height);
    
    [self.scrollView setContentSize:contentSize];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

@end
