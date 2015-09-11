//
//  Hotel.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "Hotel.h"

#import "Person.h"

@interface Hotel ()

@property (nonatomic, strong) NSMutableDictionary *rooms;

@end

@implementation Hotel

- (NSMutableDictionary *)rooms {
    if (!_rooms) {
        _rooms = [NSMutableDictionary new];
    }
    return _rooms;
}

- (NSString *)addPerson:(Person *)person {
    NSUInteger roomKey = [self.rooms count]==0 ? 0 : [self.rooms count]+1;
    NSString *roomName = [NSString stringWithFormat:@"Room%lu",roomKey];
    
    [self.rooms setObject:person forKey:roomName];
    
    return roomName;
}

- (Person *)personForRoom:(NSString *)roomKey {
    return (Person *)[self.rooms objectForKey:roomKey];
}

- (NSUInteger)totalRooms {
    return [self.rooms count];
}

- (NSArray *)allRooms {
    return [self.rooms allKeys];
}


@end
