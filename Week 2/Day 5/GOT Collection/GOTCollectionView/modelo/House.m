//
//  House.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "House.h"

@implementation House

- (void)addCharacter:(Character *)character;
{
    if(!_characters)
        _characters = [[NSArray alloc] init];
    
    _characters = [_characters arrayByAddingObject:character];
}

@end
