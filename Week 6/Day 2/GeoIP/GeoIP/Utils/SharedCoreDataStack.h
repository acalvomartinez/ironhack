//
//  SharedCoreDataStack.h
//  CoreDataHelloWorld
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStack;

@interface SharedCoreDataStack : NSObject

+ (CoreDataStack *)sharedInstanceWithDatabaseFilename:(NSString *)filename
                                   andPersistenceType:(NSString *)persistenceType;
@end
