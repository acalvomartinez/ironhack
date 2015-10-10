//
//  UsersViewController.h
//  Radars
//
//  Created by Toni on 09/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class Radar;


@protocol UsersViewControllerDelegate <NSObject>

- (void)filterResultsWithUserRadar:(Radar *)radar;

@end


@interface UsersViewController : UITableViewController

@property (nonatomic, weak) id <UsersViewControllerDelegate>delegate;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
