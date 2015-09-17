//
//  Casa.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Personaje.h"

@interface Casa : NSObject
@property (nonatomic, strong) NSString* nombre;
@property (nonatomic, strong) NSString* imagen;
@property (nonatomic, strong) NSString* lema;
@property (nonatomic, strong) NSArray* personajes;
- (void) addPersonaje:(Personaje *) personaje;
@end
