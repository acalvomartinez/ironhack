//
//  SharedCoreDataStack.m
//  CoreDataHelloWorld
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//


#import "SharedCoreDataStack.h"
#import "CoreDataStack.h"

@implementation SharedCoreDataStack

+ (CoreDataStack *)sharedInstanceWithDatabaseFilename:(NSString *)filename
                                   andPersistenceType:(NSString *)persistenceType {
    static CoreDataStack *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithDatabaseFilename:filename
                                             andPersistenceType:persistenceType];
    });
    return sharedInstance;
}

@end
