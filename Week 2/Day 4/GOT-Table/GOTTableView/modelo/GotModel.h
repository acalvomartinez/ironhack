//
//  GotModel.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GotModel : NSObject
@property (nonatomic, strong) NSArray* casas;
@property (nonatomic, strong) NSArray* personajes;
- (void) cargaModelo;
@end
