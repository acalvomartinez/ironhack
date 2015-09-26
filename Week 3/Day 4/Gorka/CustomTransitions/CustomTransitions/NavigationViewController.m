//
//  NavigationViewController.m
//  CustomTransitions
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "NavigationViewController.h"
#import "NavigationControllerAnimator.h"

@interface NavigationViewController () <UINavigationControllerDelegate>

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NavigationControllerAnimatorDirection direction;
    switch (operation) {
        case UINavigationControllerOperationPush:
            direction = NavigationControllerAnimatorDirectionRight;
            break;
        case UINavigationControllerOperationPop:
            direction = NavigationControllerAnimatorDirectionLeft;
            break;
            
        default:
            break;
    }
    
    return [[NavigationControllerAnimator alloc] initWithDirection:direction];
}

@end
