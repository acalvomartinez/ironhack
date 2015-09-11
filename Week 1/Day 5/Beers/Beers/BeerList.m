//
//  BeerList.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "BeerList.h"

#import "Beer.h"

@interface BeerList ()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation BeerList

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}

- (void)addBeer:(Beer *)beer {
    [self.list addObject:beer];
}

- (void)removeBeer:(Beer *)beer {
    [self.list removeObject:beer];
}

- (NSArray *)allBeers {
    return [self.list copy];
}

- (NSUInteger)totalBeers {
    return [self.list count];
}

@end
