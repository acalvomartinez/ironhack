//
//  ViewController.m
//  ViewsPractice
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *viewAlpha;
@property (nonatomic, strong) UIView *viewTransform;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewTransform = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.viewTransform.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 100);
    self.viewTransform.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.viewTransform];
    
    UISlider *angleSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.viewTransform.frame.origin.x, self.view.frame.size.height/2 + 50, 200, 40)];
    angleSlider.minimumValue = - M_2_PI;
    angleSlider.maximumValue = M_2_PI;
    [self.view addSubview:angleSlider];
    [angleSlider addTarget:self action:@selector(angleChanged:) forControlEvents:UIControlEventValueChanged];
    
    UISlider *scaleSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.viewTransform.frame.origin.x, self.view.frame.size.height/2 + 100, 200, 40)];
    scaleSlider.minimumValue = 0;
    scaleSlider.maximumValue = 2;
    [self.view addSubview:scaleSlider];
    [scaleSlider addTarget:self action:@selector(scaleChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)angleChanged:(UISlider *)slider {
    self.viewTransform.transform = CGAffineTransformMakeRotation(slider.value);
}

- (void)scaleChanged:(UISlider *)slider {
    self.viewTransform.transform = CGAffineTransformMakeScale(slider.value, slider.value);
}

- (void)testingContentMode {
    self.view.backgroundColor = [UIColor redColor];
    
    UIImage *image = [UIImage imageNamed:@"chewacca"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    imageView.backgroundColor = [UIColor brownColor];
    imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.image = image;
    imageView.clipsToBounds = YES;
    
    [self.view addSubview:imageView];
    
}

- (void)testingViewsPosition {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view1.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    view1.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:view1];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view2.center = CGPointMake(self.view.frame.size.width/2 + 50, self.view.frame.size.height/2 +50);
    
    view2.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:view2];
    
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view3.center = CGPointMake(self.view.frame.size.width/2 + 100, self.view.frame.size.height/2 +100);
    
    view3.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view3];
    
    [self.view addSubview:view2];
    
    [self.view insertSubview:view3 aboveSubview:view2];
    
    view1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    view2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    view3.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [UIView animateWithDuration:3 animations:^{
        view2.alpha = 0;
        view3.frame = CGRectMake(300, 300, 200, 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            view2.alpha = 1;
            view1.frame = CGRectMake(300, 300, 200, 200);
        }];
        
    }];
}

- (void)testRecursive {
    self.viewAlpha = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.viewAlpha.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.viewAlpha.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.viewAlpha];
    
    [self recursiveAlpha];
}


- (void)recursiveAlpha {
    
    __weak ViewController *weakself = self;
    
    [UIView animateWithDuration:1 animations:^{
        weakself.viewAlpha.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            weakself.viewAlpha.alpha = 1;
        } completion:^(BOOL finished) {
            [weakself recursiveAlpha];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
