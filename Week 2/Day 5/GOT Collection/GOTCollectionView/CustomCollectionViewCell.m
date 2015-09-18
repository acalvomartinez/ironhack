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
    self.nameCharacter.layer.shadowColor = [UIColor blackColor].CGColor;
    self.nameCharacter.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.nameCharacter.layer.shadowOpacity = 1.0f;
    self.nameCharacter.layer.shadowRadius = 0.0f;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 3.0f;
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
