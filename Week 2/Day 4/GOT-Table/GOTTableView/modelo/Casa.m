//
//  Casa.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "Casa.h"

@implementation Casa

- (void)addPersonaje:(Personaje *)personaje
{
    if(!_personajes)
        _personajes = [[NSArray alloc] init];
    
    _personajes = [_personajes arrayByAddingObject:personaje];
}

@end
