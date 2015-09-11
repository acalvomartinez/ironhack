//
//  BeerList.h
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Beer;

@interface BeerList : NSObject

- (void)addBeer:(Beer *)beer;
- (void)removeBeer:(Beer *)beer;
- (NSArray *)allBeers;
- (NSUInteger)totalBeers;

@end
