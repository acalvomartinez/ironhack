//
//  RadarSectionCell.m
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarSectionCell.h"

#include "Radar.h"

@interface RadarSectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation RadarSectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRadar:(Radar *)radar {
    self.titleLabel.text = radar.user;
}

@end
