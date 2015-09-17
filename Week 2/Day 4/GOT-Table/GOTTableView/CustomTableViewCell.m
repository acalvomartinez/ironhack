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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
