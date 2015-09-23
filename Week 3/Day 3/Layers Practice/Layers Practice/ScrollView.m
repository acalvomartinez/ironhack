//
//  ScrollView.m
//  Layers Practice
//
//  Created by Toni on 23/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ScrollView


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = image;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CAScrollLayer *layer = (CAScrollLayer*)self.layer;
        
        layer.scrollMode = kCAScrollVertically;
        
        [self addSubview:_imageView];
    }
    return self;
}

+ (Class)layerClass {
    return [CAScrollLayer class];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    CGPoint destination = CGPointMake(location.x - (self.bounds.size.width/2), location.y - (self.bounds.size.height/2));
    
    [UIView animateWithDuration:2 animations:^{
        CAScrollLayer *layer = (CAScrollLayer*)self.layer;
        [layer scrollToPoint:destination];
    }];
}

@end
