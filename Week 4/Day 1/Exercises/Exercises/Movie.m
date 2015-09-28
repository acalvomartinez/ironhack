//
//  Movie.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)copyWithZone:(NSZone *)zone {
    Movie *movieCopy = [[[self class] alloc]init];
    
    if (movieCopy) {
        movieCopy.movieId = [self.movieId copyWithZone:zone];
        movieCopy.title = [self.title copyWithZone:zone];
        movieCopy.movieDescription = [self.movieDescription copyWithZone:zone];
        movieCopy.rating = self.rating;
    }
    return movieCopy;
}

@end
