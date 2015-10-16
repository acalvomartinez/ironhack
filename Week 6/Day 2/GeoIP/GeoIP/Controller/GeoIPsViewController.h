//
//  GeoIPsViewController.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "RotatingTableViewController.h"

@interface GeoIPsViewController : RotatingTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
