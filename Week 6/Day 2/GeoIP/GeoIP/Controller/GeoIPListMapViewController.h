//
//  GeoIPListMapViewController.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "RotatingViewController.h"

@interface GeoIPListMapViewController : RotatingViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
