//
//  UIAlertView+Block.m
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static const char kDismissBlockKey;
static const char kCancelBlockKey;

@implementation UIAlertView (Block)

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtons
                          onDismiss:(DismissBlock)dismissed
                           onCancel:(CancelBlock)cancelled {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                       message:message
                                                      delegate:[self class]
                                             cancelButtonTitle:cancelButtonTitle
                                             otherButtonTitles:nil];
    
    alertView.dismissBlock = dismissed;
    alertView.cancelBlock = cancelled;
    
    for (NSString *buttonTitle in otherButtons) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    return alertView;
    
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
    } else {
        alertView.dismissBlock(buttonIndex);
    }
}
#pragma mark - Associated objects

- (DismissBlock)dismissBlock {
    return objc_getAssociatedObject(self, &kDismissBlockKey);
}

- (void)setDismissBlock:(DismissBlock)dismissBlock {
    objc_setAssociatedObject(self, &kDismissBlockKey, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CancelBlock)cancelBlock {
    return objc_getAssociatedObject(self, &kDismissBlockKey);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock {
    objc_setAssociatedObject(self, &kCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
