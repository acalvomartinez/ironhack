//
//  Radar.h
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Radar : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (Radar *)radarWithUser:(NSString *)user
                andTitle:(NSString *)title
                 product:(NSString *)product
          productVersion:(NSString *)productVersion
               inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)fetchRequestWithFields:(NSArray<NSString *> *)fields
                                 andOrders:(NSArray<NSNumber *> *)orders
                        andDistinctResults:(BOOL)distinct;

@end

NS_ASSUME_NONNULL_END

#import "Radar+CoreDataProperties.h"
