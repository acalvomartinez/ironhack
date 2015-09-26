//
//  ViewController.m
//  GestureRecognizers
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "ViewController.h"
#import "ImagePreviewViewController.h"
#import "ImagePreviewAnimator.h"

@interface ViewController () <UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIImageView *currentManipulatedView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGestureRecognizer.numberOfTouchesRequired = 1;
    longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self.view addGestureRecognizer:longPressGestureRecognizer];
    
    [tapGestureRecognizer requireGestureRecognizerToFail:longPressGestureRecognizer];
}





- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIImageView *imageViewBehindGestureRecognizer = [self imageViewBehindGestureRecognizerIfAny:gestureRecognizer];
    if (!imageViewBehindGestureRecognizer) {
        return NO;
    }
    
    self.currentManipulatedView = imageViewBehindGestureRecognizer;
    [self.view bringSubviewToFront:imageViewBehindGestureRecognizer];
    
    return YES;
}



#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 200)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cat%d", arc4random_uniform(2)]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    
    CGPoint tapLocation = [tapGestureRecognizer locationInView:self.view];
    imageView.center = tapLocation;
    
    [self.view addSubview:imageView];
}














- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (pinchGestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    self.currentManipulatedView.transform = CGAffineTransformScale(self.currentManipulatedView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
}















- (void)handleRotation:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
    if (rotationGestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    self.currentManipulatedView.transform = CGAffineTransformRotate(self.currentManipulatedView.transform, rotationGestureRecognizer.rotation);
    rotationGestureRecognizer.rotation = 0;
}











- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    self.currentManipulatedView.center = CGPointMake(self.currentManipulatedView.center.x + translation.x, self.currentManipulatedView.center.y + translation.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
}









- (void)handleLongPress:(UILongPressGestureRecognizer *)longPressGesture {
    if (longPressGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    self.currentManipulatedView = [self imageViewBehindGestureRecognizerIfAny:longPressGesture];
    
    ImagePreviewViewController *imagePreviewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagePreviewControllerIdentifier"];
    imagePreviewViewController.fullSizedImage = self.currentManipulatedView.image;
    imagePreviewViewController.modalPresentationStyle = UIModalPresentationCustom;
    imagePreviewViewController.transitioningDelegate = self;
    
    [self presentViewController:imagePreviewViewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (![presented isKindOfClass:[ImagePreviewViewController class]]) {
        return nil;
    }
    
    return [ImagePreviewAnimator animatorWithImageView:self.currentManipulatedView];
}










- (UIImageView *)imageViewBehindGestureRecognizerIfAny:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    UIView *gestureView = [self.view hitTest:point withEvent:nil];
    if (![gestureView isKindOfClass:[UIImageView class]]) {
        return nil;
    }
    
    return (UIImageView *)gestureView;
}


@end
