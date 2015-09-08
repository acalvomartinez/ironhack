//
//  Fruit.m
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "Fruit.h"

@implementation Fruit

- (BOOL) isApple {
    return [self.name isEqualToString:@"Apple"] ?  YES : NO;
}

- (BOOL) isWatermelon{
    return [self.name isEqualToString:@"Watermelon"] ?  YES : NO;
}

@end
