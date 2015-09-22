//
//  DragView.m
//  ViewManagement Excercise
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "DragView.h"

@interface DragView ()

@end

@implementation DragView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self];
        
        if ([touch.view isEqual:self]) {
            [self createDragViewInLocation:location];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self];
        
        for (UIView *subview in [self subviews]) {
            if (CGRectContainsPoint(subview.frame, location)) {
                [self moveDragView:subview ToPoint:location];
            }
        }
    }
}

- (void)createDragViewInLocation:(CGPoint)location {
    UIView *dragView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    dragView.backgroundColor = [UIColor redColor];
    dragView.center = location;
    [self addSubview:dragView];
}

- (void)moveDragView:(UIView *)view ToPoint:(CGPoint)location {
    view.center = location;
}


@end
