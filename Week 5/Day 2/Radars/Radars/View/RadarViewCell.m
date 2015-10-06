//
//  RadarViewCell.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarViewCell.h"

#import "Radar.h"

@interface RadarViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *radarText;
@property (weak, nonatomic) IBOutlet UILabel *radarUser;
@end

@implementation RadarViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRadar:(Radar *)radar {
    self.radarText.text = radar.title;
    self.radarUser.text = radar.user;
}

@end
