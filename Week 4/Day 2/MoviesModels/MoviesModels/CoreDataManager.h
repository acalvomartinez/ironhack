//
//  CoreDataStack.h
//  MoviesModels
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
