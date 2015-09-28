//
//  Bookmark.m
//  NSCoding Practice
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
