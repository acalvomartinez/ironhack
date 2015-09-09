//
//  IronhackPerson.h
//  ObjectsMessagesExercise
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IronhackPerson : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableString *lastname;
@property (strong, nonatomic) NSDate *birthday;

@property (weak, nonatomic) IronhackPerson *master;
@property (strong, nonatomic) IronhackPerson *padawan;

+ (instancetype)person;
+ (instancetype)personWithName:(NSString *)name lastname:(NSString *)lastname birthday:(NSDate *)birthday;

- (instancetype)initWithName:(NSString *)name
                    lastname:(NSString *)lastname
                    birthday:(NSDate *)birthday NS_DESIGNATED_INITIALIZER;

- (instancetype)init;

- (void) sayHello;
- (void) saySomething:(NSString *)greeting;

@end
