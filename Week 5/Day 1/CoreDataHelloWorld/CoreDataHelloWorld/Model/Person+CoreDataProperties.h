//
//  Person+CoreDataProperties.h
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *happy;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *partnerName;

@end

NS_ASSUME_NONNULL_END
