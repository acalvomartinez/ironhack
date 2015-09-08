//
//  Person.h
//  OOP
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Flower.h"

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) int age;

@property (strong, nonatomic) Flower *flower;

- (instancetype)initWithName:(NSString *)name;
- (BOOL)sendMyFlowerTo:(Person *)target;

@end
