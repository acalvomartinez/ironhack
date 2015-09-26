//
//  NavigationControllerAnimator.h
//  CustomTransitions
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NavigationControllerAnimatorDirection) {
    NavigationControllerAnimatorDirectionRight,
    NavigationControllerAnimatorDirectionLeft
};

@interface NavigationControllerAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithDirection:(NavigationControllerAnimatorDirection)direction NS_DESIGNATED_INITIALIZER;
@end
