//
//  ShoppingCart.h
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemCart;

@interface ShoppingCart : NSObject

- (BOOL)addItem:(ItemCart *)item;
- (double)totalPrice;

@end
