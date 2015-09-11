//
//  Person.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithName:(NSString *)name {
    return [self personWithName:name address:nil];
}

+ (instancetype)personWithName:(NSString *)name
                       address:(NSString *)address {
    return [[self alloc] initWithName:name
                              address:address];
}

- (instancetype)initWithName:(NSString *)name {
    return [self initWithName:name address:nil];
}

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address {
    return [self initWithName:name address:address age:0];
}

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                         age:(NSUInteger)age {
    if (self = [super init]) {
        _name = name;
        _address = address;
        _age = age;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Person: %@, %@, %lu, Married: %@>", self.name, self.address, self.age, self.isMarried ? @"Yes" : @"No"];
}
@end
