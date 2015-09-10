//
//  MyCustomView.m
//  MyFirstApp
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "MyCustomView.h"

@implementation MyCustomView


- (void)drawRect:(CGRect)rect {
    
    CGFloat y = self.bounds.size.height / 2;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(c, 0, y);
    CGContextAddLineToPoint(c, self.bounds.size.width, y);
    CGContextSetStrokeColorWithColor(c, [self.lineColor CGColor]);
    CGContextStrokePath(c);
}


@end
