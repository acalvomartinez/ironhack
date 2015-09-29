//
//  MoviesTableViewController.h
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreData;

@interface MoviesTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedContext;

@end

