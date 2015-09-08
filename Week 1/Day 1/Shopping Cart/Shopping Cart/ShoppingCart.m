//
//  ShoppingCart.m
//  Shopping Cart
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ShoppingCart.h"

#import "ItemCart.h"
#import "Fruit.h"

double const kDiscount = 5;
double const kNumItemsDiscount = 5;

int const kNumApplesDiscount = 2;
double const kApplesDiscount = 5;

double const kPriceTotalItem = 100;
double const kPriceTotalItemDiscount = 10;

double const kWatermelonsDiscount = 10;


@interface ShoppingCart ()

@property (strong, nonatomic) NSMutableArray *items;

@end


@implementation ShoppingCart

- (instancetype)init {
    if (self = [super init]) {
        _items = [NSMutableArray new];
    }
    return self;
}

- (BOOL)addItem:(ItemCart *)item {
    if (item) {
        [self.items addObject:item];
        return YES;
    } else {
        return NO;
    }
}

- (double)totalPrice {
    double total = 0;
    
    int numApples = 0;
    
    BOOL isWeekend = [self checkForWeekend:[NSDate date]];
    
    for (Fruit *item in self.items) {
        
        if (isWeekend && [item isWatermelon]) {
            total += (item.price - (item.price * kWatermelonsDiscount / 100));
        } else {
        
            if ([item isApple]) {
                numApples ++;
                
                if ((numApples%2) == 1) {
                    total += item.price;
                }
            } else {
                total += item.price;
            }
        }
    }
    
    return [self applyDiscountsToPrice:total];
}

- (double)applyDiscountsToPrice:(double)price {
    double total = price;
    
    total = [self discountByNumItemsToPrice:total];
    total = [self discountByTotalPriceToPrice:total];
    
    return total;
}

- (double)discountByNumItemsToPrice:(double)price {
    if ([self.items count] > kNumItemsDiscount) {
        price = price - (price * kDiscount / 100);
    }
    
    return price;
}

- (double)discountByTotalPriceToPrice:(double)price {
    
    if (price > kPriceTotalItem) {
        price = price - kPriceTotalItemDiscount;
    }
    
    return price;
}




- (BOOL)checkForWeekend:(NSDate *)aDate {
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComps = [calendar components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    return (todayComps.weekday == 6 || todayComps.weekday == 7) ? YES : NO;
}





@end
