//
//  NavigationControllerAnimator.m
//  CustomTransitions
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "NavigationControllerAnimator.h"

@interface NavigationControllerAnimator ()
@property (nonatomic) NavigationControllerAnimatorDirection direction;
@end

@implementation NavigationControllerAnimator

- (instancetype)initWithDirection:(NavigationControllerAnimatorDirection)direction {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.direction = direction;
    return self;
}




static CGFloat const kDuration = 0.25;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromViewControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toViewControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    // We add 0.00001 to M_PI to let UIKit know we are bit close to one side than the other so it rotates to the desired direction. Try removing this tiny number and see what happens.
    CGFloat rotation = (self.direction == NavigationControllerAnimatorDirectionRight) ? M_PI+0.00001 : -(M_PI+0.00001);
    
    toViewControllerView.alpha = 0.0;
    toViewControllerView.transform = CGAffineTransformMakeRotation(rotation);
    [containerView addSubview:toViewControllerView];
    
    [UIView animateWithDuration:kDuration animations:^{
        toViewControllerView.alpha = 1.0;
        toViewControllerView.transform = CGAffineTransformIdentity;
        
        fromViewControllerView.alpha = 0.0;
        fromViewControllerView.transform = CGAffineTransformMakeRotation(-rotation);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

@end
