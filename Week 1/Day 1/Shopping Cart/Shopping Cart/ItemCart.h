//
//  ItemCart.h
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemCart : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) double price;

- (instancetype)initWithName:(NSString *)name price:(double)price;

@end
