//
//  main.m
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Fruit.h"
#import "ShoppingCart.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Fruit *apple = [[Fruit alloc] initWithName:@"Apple" price:10.5];
        Fruit *orange = [[Fruit alloc] initWithName:@"Orange" price:5.5];
        Fruit *grapes = [[Fruit alloc] initWithName:@"Grapes" price:10.6];
        Fruit *banana = [[Fruit alloc] initWithName:@"Banana" price:20.3];
        Fruit *watermelon = [[Fruit alloc] initWithName:@"Watermelon" price:50.33];
       
        ShoppingCart *cart = [[ShoppingCart alloc] init];
        [cart addItem:apple];
        [cart addItem:apple];
        [cart addItem:apple];
        [cart addItem:apple];
        [cart addItem:apple];
        [cart addItem:apple];
        [cart addItem:orange];
        [cart addItem:grapes];
        [cart addItem:banana];
        [cart addItem:watermelon];
        [cart addItem:watermelon];
        [cart addItem:watermelon];
        
        NSLog(@"Total Price: %.2f", cart.totalPrice);
        
    }
    return 0;
}
