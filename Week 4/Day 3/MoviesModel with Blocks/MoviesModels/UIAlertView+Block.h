//
//  UIAlertView+Block.h
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Block)<UIAlertViewDelegate>

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSArray *)otherButtons
                        onDismiss:(DismissBlock)dismissed
                         onCancel:(CancelBlock)cancelled;

@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;


@end
