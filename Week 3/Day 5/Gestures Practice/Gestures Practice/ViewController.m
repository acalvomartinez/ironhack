//
//  ViewController.m
//  Gestures Practice
//
//  Created by Toni on 25/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *currentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleTapGesture:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handlePinchGesture:)];
    pinchGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handleRotationGesture:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}


- (void)createImageInLocation:(CGPoint)location {
    CGRect frame = CGRectMake(0, 0, 200, 200);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 100;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"vader"];
    imageView.image = image;
    
    imageView.center = location;
    
    [self.view addSubview:imageView];
}

#pragma mark - Gestures

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint location = [tapGestureRecognizer locationInView:self.view];
    
    [self createImageInLocation:location];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (pinchGestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    self.currentView.transform = CGAffineTransformScale(self.currentView.transform,pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1.0;
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)rotationGesture {
    if (rotationGesture.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    self.currentView.transform = CGAffineTransformRotate(self.currentView.transform, rotationGesture.rotation);
    rotationGesture.rotation = 0.0;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    CGPoint translation = [panGesture translationInView:self.view];
    self.currentView.center = CGPointMake(self.currentView.center.x + translation.x, self.currentView.center.y + translation.y);
    [panGesture setTranslation:CGPointZero inView:self.view];
}

- (UIImageView *)imageViewBehindGestureRecognizerIfAny:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self.view];
    UIView *tappedView = [self.view hitTest:location withEvent:nil];
    
    if (![tappedView isKindOfClass:[UIImageView class]]) {
        return nil;
    }
    return (UIImageView*)tappedView;
}

#pragma mark - Gestures Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    self.currentView = [self imageViewBehindGestureRecognizerIfAny:gestureRecognizer];
    
    [self.view bringSubviewToFront:self.currentView];
    
    return self.currentView != nil;
}

@end
