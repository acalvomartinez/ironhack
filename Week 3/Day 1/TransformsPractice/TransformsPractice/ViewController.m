//
//  ViewController.m
//  TransformsPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *transformView1;
@property (weak, nonatomic) IBOutlet UIView *transformView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self applyRotationTransform];
    [self applyScaleTransform];
    
    
    self.transformView1.transform = [self applyScaleToTransform:CGAffineTransformIdentity];
    self.transformView1.transform = [self applyRotationToTransform:self.transformView1.transform];
}

- (void)applyScaleTransform {
    self.transformView2.transform = CGAffineTransformMakeScale(2.0, 2.0);
}

- (void)applyRotationTransform {
    self.transformView2.transform = CGAffineTransformMakeRotation(degreesToRadians(45));
}

- (CGAffineTransform)applyScaleToTransform:(CGAffineTransform)transform {
    return CGAffineTransformScale(transform, 2.0, 2.0);
}

- (CGAffineTransform)applyRotationToTransform:(CGAffineTransform)transform {
    return CGAffineTransformRotate(transform, degreesToRadians(45));
}

@end
