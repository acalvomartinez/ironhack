//
//  DeformableView.m
//  Shapes
//
//  Created by Gorka Magaña on 24/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "DeformableView.h"

@implementation DeformableView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    self.xDisplacement = 0;
}

- (void)setXDisplacement:(CGFloat)xDisplacement {
    NSLog(@"New x-displacement: %f", xDisplacement);
    _xDisplacement = xDisplacement;
    
    [self.layer removeAllAnimations];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    UIBezierPath *newShape = [self shapeWithControlPoint:CGPointMake(xDisplacement, 0)];
    shapeLayer.path = newShape.CGPath;
}






- (void)resetShape {
    BOOL isFromRight = self.xDisplacement > 0;
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnimation.values = @[(id)[self shapeWithControlPoint:CGPointMake(self.xDisplacement, 0)].CGPath,
                             (id)[self shapeWithControlPoint:CGPointMake(isFromRight ? -20 : 20, 0)].CGPath,
                             (id)[self shapeWithControlPoint:CGPointMake(isFromRight ? 8 : -8, 0)].CGPath,
                             (id)[self shapeWithControlPoint:CGPointMake(isFromRight ? -8 : 8, 0)].CGPath,
                             (id)[self shapeWithControlPoint:CGPointMake(isFromRight ? - 2 : 2, 0)].CGPath,
                             (id)[self shapeWithControlPoint:CGPointZero].CGPath];
    pathAnimation.duration = 0.6;
    
    [self.layer addAnimation:pathAnimation forKey:@"pathRecovery"];
    
    _xDisplacement = 0;
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.path = [self shapeWithControlPoint:CGPointZero].CGPath;
}








- (UIBezierPath *)shapeWithControlPoint:(CGPoint)controlPoint {
    CGRect frame = self.bounds;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    
    // Left vertex
    [bezierPath addQuadCurveToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame))
                       controlPoint:CGPointMake(CGRectGetMinX(frame) + controlPoint.x, CGRectGetMidY(frame))];
    
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame))];
    
    // Right vertex
    [bezierPath addQuadCurveToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame))
                       controlPoint:CGPointMake(CGRectGetMaxX(frame) + controlPoint.x, CGRectGetMidY(frame))];
    
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame))];
    [bezierPath closePath];
    
    return bezierPath;
}

@end
