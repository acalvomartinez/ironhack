//
//  TableViewCell.h
//  GOTTableView
//
//  Created by Toni on 17/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageCharacterView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (void)setOffset:(float)p;


@end
