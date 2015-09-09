//
//  IronhackPerson.m
//  ObjectsMessagesExercise
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "IronhackPerson.h"

@implementation IronhackPerson

+ (instancetype) person {
    return [[self alloc] initWithName:nil lastname:nil birthday:nil];
}

+ (instancetype) personWithName:(NSString *)name lastname:(NSString *)lastname birthday:(NSDate *)birthday {
    return [[self alloc] initWithName:name lastname:lastname birthday:birthday];
}

- (instancetype)initWithName:(NSString *)name lastname:(NSString *)lastname birthday:(NSDate *)birthday {
    if (self = [super init]) {
        _name = name;
        _lastname = [lastname mutableCopy];
        _birthday = birthday;
        _master = nil;
        _padawan = nil;
    }
    return self;
}

- (instancetype)init {
    return [self initWithName:nil lastname:nil birthday:nil];
}

- (void) sayHello {
    NSString *hello = [NSString stringWithFormat:@"Hello, Ironhack! I'm %@ %@",self.name, self.lastname];
    [self saySomething:hello];
}

- (void) saySomething:(NSString *)greeting {
    NSLog(@"%@", greeting);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<IronhackPerson: %@ %@ %@>",self.name,self.lastname,self.birthday];
}

- (void)dealloc {
    NSLog(@"%@ is dead!",self.name);
}

@end
