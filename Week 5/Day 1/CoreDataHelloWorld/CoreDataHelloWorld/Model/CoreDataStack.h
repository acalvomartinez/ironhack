//
//  CoreDataStack.h
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (instancetype)initWithDatabaseFilename:(NSString *)filename andPersistenceType:(NSString *)persistenceType;
- (void)saveContext;

@end
