//
//  CustomView.m
//  SubclassingViewsPractice
//
//  Created by Toni on 21/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CustomView

- (instancetype)init {
    return [self initWithFrame:CGRectZero title:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame title:nil];
}

- (instancetype) initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
    frame.size = [self.titleLabel sizeThatFits:self.bounds.size];
    frame.origin = CGPointMake(CGRectGetMidX(self.frame) - (frame.size.width / 2), 40);
    
    self.titleLabel.frame = frame;
}

#pragma mark - Initializers

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
