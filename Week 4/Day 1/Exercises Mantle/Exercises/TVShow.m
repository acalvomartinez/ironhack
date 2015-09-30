//
//  TVShows.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "TVShow.h"

@implementation TVShow

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tvShowId" : @"id",
             @"title" : @"title",
             @"tvShowDescription" : @"description"
             };
}

@end
