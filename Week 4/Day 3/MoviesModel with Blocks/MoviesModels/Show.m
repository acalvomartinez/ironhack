//
//  Show.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "Show.h"

@implementation Show

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"showDescription": @"description",
             @"showTitle": @"title",
             @"showId": @"id"
             };
}

@end
