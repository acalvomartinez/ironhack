//
//  MyButton.m
//  ViewManagement Excercise
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "MyButton.h"

@interface MyButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation MyButton

- (instancetype)init {
    return [self initWithFrame:CGRectZero title:nil color:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame title:nil color:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                        color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = color;
        [self addSubview:_titleLabel];
        
        CGRect shadowFrame = CGRectMake(0, frame.size.height - 5, frame.size.width, 5);
        _shadowView = [[UIView alloc]initWithFrame:shadowFrame];
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.3;
        [self addSubview:_shadowView];
    }
    return self;
}

- (void)shadowOn {
    CGRect shadowFrame = self.bounds;
    self.shadowView.frame = shadowFrame;
}


- (void)shadowOff{
    CGRect shadowFrame = CGRectMake(0, self.frame.size.height - 5, self.frame.size.width, 5);
    self.shadowView.frame = shadowFrame;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shadowOn];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shadowOff];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shadowOff];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    _titleLabel.backgroundColor = _color;
}

@end
