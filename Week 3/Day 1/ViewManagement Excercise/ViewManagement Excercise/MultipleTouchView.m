//
//  MultipleTouchView.m
//  ViewManagement Excercise
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "MultipleTouchView.h"

@implementation MultipleTouchView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self removeAllSubviews];
    
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        [self createSubviewInPoint:location];
    }
}

- (void)removeAllSubviews {
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
}

- (void)createSubviewInPoint:(CGPoint)location {
    
    CGRect frame = CGRectMake(0, 0, 30, 30);
    
    UIView *subview = [[UIView alloc]initWithFrame:frame];
    subview.center = location;
    
    subview.backgroundColor = [UIColor redColor];
    [self addSubview:subview];
}

@end
