//
//  CoreDataStack.m
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "CoreDataStack.h"

#import "FileUtils.h"

@interface CoreDataStack ()
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *persistenceType;
@end

@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;

- (instancetype)initWithDatabaseFilename:(NSString *)filename
                      andPersistenceType:(NSString *)persistenceType {
    self = [super init];
    if (self) {
        _filename = filename;
        _persistenceType = persistenceType;
    }
    return self;
}

- (instancetype)init {
    return [self initWithDatabaseFilename:@"database.sqlite" andPersistenceType:NSInMemoryStoreType];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
   
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[FileUtils applicationDocumentsDirectory] URLByAppendingPathComponent:self.filename];
    
    // NSMigratePersistentStoresAutomaticallyOption Versionado automatico
    
    NSDictionary *options =  @{
                               NSMigratePersistentStoresAutomaticallyOption: @YES,
                               NSInferMappingModelAutomaticallyOption: @YES
                               };
    
    NSError *error = nil;
    if (![persistentStoreCoordinator addPersistentStoreWithType:self.persistenceType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = @"There was an error creating or loading the application's saved data.";
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"com.ironhack.radars" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    NSManagedObjectModel *_managedObjectModel;
    
    NSBundle *bundle = [NSBundle mainBundle];
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    return _managedObjectModel;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
