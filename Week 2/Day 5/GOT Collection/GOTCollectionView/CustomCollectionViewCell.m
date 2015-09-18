//
//  CustomCollectionViewCell.m
//  GOTCollectionView
//
//  Created by Toni on 18/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()


@end

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView.layer.borderWidth = 10.0;
    self.imageView.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 3.0f;

    //UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    //self.layer.shadowPath = shadowPath.CGPath;
    //self.imageView.layer.cornerRadius = 15.0;
    //self.imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.imageView.layer.borderColor = [[UIColor redColor] CGColor];
    } else {
        self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
}

@end
