//
//  NSManagedObjectContext+ACMInsertManagedObject.h
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (ACMInsertManagedObject)

- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName;

@end
