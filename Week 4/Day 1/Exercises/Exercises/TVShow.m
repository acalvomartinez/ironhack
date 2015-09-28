//
//  TVShows.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "TVShow.h"

@implementation TVShow

- (id)copyWithZone:(NSZone *)zone {
    TVShow *tvShowCopy = [[[self class] alloc] init];
    
    if (tvShowCopy) {
        tvShowCopy.tvShowId = [self.tvShowId copyWithZone:zone];
        tvShowCopy.title = [self.title copyWithZone:zone];
        tvShowCopy.tvShowDescription = [self.tvShowDescription copyWithZone:zone];
        tvShowCopy.rating = self.rating;
    }
    
    return tvShowCopy;
}

@end
