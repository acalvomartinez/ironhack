//
//  Show.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "Show.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@import UIKit;

@implementation Show

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"showDescription": @"description",
             @"showTitle": @"title",
             @"showId": @"id",
             @"posterURL" : @"posterURL"
             };
}


+ (NSValueTransformer*)posterURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (UIImage *)posterImage {
    if (!self.posterURL) {
        return nil;
    }
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.posterURL];
    return [UIImage imageWithData:imageData];
}

@end
