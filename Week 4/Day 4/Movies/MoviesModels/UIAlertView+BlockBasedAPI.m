//
//  UIAlertView+BlockBasedAPI.m
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "UIAlertView+BlockBasedAPI.h"

#import <objc/runtime.h>

static const char kConfirmBlockKey;

@implementation UIAlertView (BlockBasedAPI)


+ (UIAlertView *)alerViewConfirmWithTitle:(NSString *)title confirmActionBlock:(AlertViewConfirmActionBlock)confirmBlock {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:@"Confirm?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK",nil];
    
    alertView.delegate = self;
    alertView.acm_confirmBlock = confirmBlock;
    
    return alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        alertView.acm_confirmBlock();
    }
}


#pragma mark - Associated objects

- (AlertViewConfirmActionBlock)acm_confirmBlock {
    return objc_getAssociatedObject(self, &kConfirmBlockKey);
}

- (void)setAcm_confirmBlock:(AlertViewConfirmActionBlock)confirmBlock {
    self.delegate = self;
    
    objc_setAssociatedObject(self, &kConfirmBlockKey, confirmBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
