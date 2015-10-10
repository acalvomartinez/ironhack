//
//  Radar.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Radar.h"

#import "NSManagedObjectContext+ACMInsertManagedObject.h"

@implementation Radar

// Insert code here to add functionality to your managed object subclass

+ (Radar *)radarWithUser:(NSString *)user
                andTitle:(NSString *)title
                 product:(NSString *)product
          productVersion:(NSString *)productVersion
               inContext:(NSManagedObjectContext *)context {
    Radar *radar = (Radar *)[context insertNewObjectForEntityForName:[Radar description]];
    radar.user = user;
    radar.title = title;
    radar.product = product;
    radar.productVersion = productVersion;
    
    return radar;
}


+ (NSFetchRequest *)fetchRequestWithFields:(NSArray<NSString *> *)fields
                                 andOrders:(NSArray<NSNumber *> *)orders
                        andDistinctResults:(BOOL)distinct {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[Radar description]];
    [fetchRequest setFetchBatchSize:20];
    
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:fields.count];
    
    for (NSString *key in fields) {
        NSUInteger index = [fields indexOfObject:key];
        
        BOOL ascending = (orders.count > index) ? [[orders objectAtIndex:index] boolValue] : NO;

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        
        [sortDescriptors addObject:sortDescriptor];
    }
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchRequest.returnsDistinctResults = distinct;
        
    return fetchRequest;
}

@end
