//
//  Person.h
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic) NSUInteger age;
@property (nonatomic, getter=isMarried) BOOL married;


+ (instancetype)personWithName:(NSString *)name;

+ (instancetype)personWithName:(NSString *)name
                       address:(NSString *)address;

- (instancetype)initWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                         age:(NSUInteger)age NS_DESIGNATED_INITIALIZER;


@end
