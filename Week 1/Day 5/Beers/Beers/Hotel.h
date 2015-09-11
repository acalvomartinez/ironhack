//
//  Hotel.h
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Hotel : NSObject

- (NSString *)addPerson:(Person *)person;
- (Person *)personForRoom:(NSString *)roomKey;
- (NSUInteger)totalRooms;
- (NSArray *)allRooms;


@end
