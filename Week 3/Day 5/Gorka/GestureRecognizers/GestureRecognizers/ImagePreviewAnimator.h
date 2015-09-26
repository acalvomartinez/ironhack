//
//  ImagePreviewAnimator.h
//  GestureRecognizers
//
//  Created by Gorka Magaña on 25/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagePreviewAnimator : NSObject <UIViewControllerAnimatedTransitioning>
+ (instancetype)animatorWithImageView:(UIImageView *)imageView;
@end
