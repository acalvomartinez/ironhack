//
//  House.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface House : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *motto;
@property (nonatomic, strong) NSArray *characters;

- (void)addCharacter:(Character *)character;

@end
