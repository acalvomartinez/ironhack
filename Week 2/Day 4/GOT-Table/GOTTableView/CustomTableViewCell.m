//
//  TableViewCell.m
//  GOTTableView
//
//  Created by Toni on 17/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageCharacterView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageCharacterView.layer.borderWidth = 2.0;
    self.imageCharacterView.layer.cornerRadius = self.imageCharacterView.frame.size.width/2;
    self.imageCharacterView.layer.masksToBounds = YES;
    
    self.backgroundImageView.clipsToBounds = YES;
}


- (void)setOffset:(float)p {
    CGRect imageFrame = self.backgroundImageView.frame;
    imageFrame.origin = CGPointMake(0, -p*(self.backgroundImageView.frame.size.height-self.bounds.size.height));
    self.backgroundImageView.frame = imageFrame;
    self.clipsToBounds = YES;
}

@end
