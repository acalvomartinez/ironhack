//
//  CustomBarButtonItem.m
//  MoviesModels
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "CustomBarButtonItem.h"

#import "UIAlertView+Block.h"

#import <libextobjc/EXTScope.h>

@interface CustomBarButtonItem () <UIAlertViewDelegate>

@property (copy, nonatomic) ActionBlock actionBlock;

@end

@implementation CustomBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(ActionBlock)actionBlock {
    if (self = [super initWithTitle:title style:style target:self action:@selector(executionAction:)]) {
        _actionBlock = actionBlock;
    }
    return self;
}

- (void)executionAction:(id)sender {
    self.actionBlock();
}

@end
