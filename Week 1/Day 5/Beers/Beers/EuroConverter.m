//
//  EuroConverter.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "EuroConverter.h"

#define CONVERT_VALUE 166.386

@implementation EuroConverter


+ (int)convertFromEuroToPeseta:(float)euros {
    return (int)(euros*CONVERT_VALUE);
}

+ (float)convertFromPesetaToEuro:(int)pesetas {
    return pesetas/CONVERT_VALUE;
}

- (int)convertFromEuroToPeseta {
    return [self.class convertFromEuroToPeseta:self.money];
}

- (float)convertFromPesetaToEuro {
    return [self.class convertFromPesetaToEuro:(int)self.money];
}

@end
