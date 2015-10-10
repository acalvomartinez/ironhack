//
//  NSManagedObjectContext+ACMInsertManagedObject.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "NSManagedObjectContext+ACMInsertManagedObject.h"

@implementation NSManagedObjectContext (ACMInsertManagedObject)

- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName {
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
    
    return object;
}

@end
