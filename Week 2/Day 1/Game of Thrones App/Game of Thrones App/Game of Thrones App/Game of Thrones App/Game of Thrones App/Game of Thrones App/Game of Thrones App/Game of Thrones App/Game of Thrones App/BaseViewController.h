//
//  BaseViewController.h
//  Game of Thrones App
//
//  Created by Toni on 14/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const padding;
UIKIT_EXTERN CGFloat const margin;
UIKIT_EXTERN CGFloat const heightUnit;
UIKIT_EXTERN CGFloat const initialUpperMargin;

@interface BaseViewController : UIViewController

- (void)placeView:(UIView *)bottomView underView:(UIView *)upperWiew withHeightUnits:(CGFloat)heightUnits;
- (CGRect)frameUnderFrame:(CGRect)sourceFrame withHeightUnits:(CGFloat)heightUnits;

@end
