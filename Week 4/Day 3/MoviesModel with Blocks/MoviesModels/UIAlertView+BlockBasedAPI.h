//
//  UIAlertView+BlockBasedAPI.h
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewConfirmActionBlock)();

@interface UIAlertView (BlockBasedAPI) <UIAlertViewDelegate>

@property (nonatomic, copy) AlertViewConfirmActionBlock acm_confirmBlock;

+ (UIAlertView *)alerViewConfirmWithTitle:(NSString *)title confirmActionBlock:(AlertViewConfirmActionBlock)confirmBlock;

@end
