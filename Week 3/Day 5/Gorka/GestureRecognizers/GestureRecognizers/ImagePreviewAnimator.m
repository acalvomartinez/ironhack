//
//  ImagePreviewAnimator.m
//  GestureRecognizers
//
//  Created by Gorka Magaña on 25/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "ImagePreviewAnimator.h"
#import "ImagePreviewViewController.h"

@interface ImagePreviewAnimator ()
@property (nonatomic, strong) UIImageView *fromImageView;
@end

@implementation ImagePreviewAnimator

+ (instancetype)animatorWithImageView:(UIImageView *)imageView {
    ImagePreviewAnimator *animator = [[self alloc] init];
    animator.fromImageView = imageView;
    
    return animator;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    ImagePreviewViewController *imagePreviewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView *toImageView = imagePreviewController.imageView;
    [toView setNeedsLayout];
    [toView layoutIfNeeded];
    
    UIImageView *transitionImageView = [[UIImageView alloc] initWithImage:self.fromImageView.image];
    transitionImageView.bounds = self.fromImageView.bounds;
    transitionImageView.center = self.fromImageView.center;
    transitionImageView.transform = self.fromImageView.transform;
    transitionImageView.clipsToBounds = self.fromImageView.clipsToBounds;
    transitionImageView.contentMode = self.fromImageView.contentMode;
    [containerView addSubview:transitionImageView];
    
    fromView.alpha = 1.0;
    toView.hidden = YES;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:0 animations:^{
        fromView.alpha = 0.0;
        transitionImageView.transform = CGAffineTransformIdentity;
        transitionImageView.frame = toImageView.frame;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        [toView sendSubviewToBack:toImageView];
        [transitionImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
