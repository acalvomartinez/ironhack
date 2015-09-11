//
//  EuroConverter.h
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface EuroConverter : NSObject

@property (assign, nonatomic) CGFloat money;

+ (int)convertFromEuroToPeseta:(float)euros;
+ (float)convertFromPesetaToEuro:(int)pesetas;

- (int)convertFromEuroToPeseta;
- (float)convertFromPesetaToEuro;

@end
