//
//  ItemCart.m
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ItemCart.h"

@implementation ItemCart

- (instancetype)initWithName:(NSString *)name price:(double)price {
    if (self = [super init]) {
        _name = name;
        _price = price;
    }
    return self;
}

@end
