//
//  RadarsViewController.h
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class RadarViewCell;

@interface RadarsViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(RadarViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
