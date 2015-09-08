//
//  Person.m
//  OOP
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (BOOL)sendMyFlowerTo:(Person *)target
{
    if (self.flower && !target.flower) {
        target.flower = self.flower;
        self.flower = nil;
        return YES;
    }
    
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Person: %@>",self.name];
}

@end
