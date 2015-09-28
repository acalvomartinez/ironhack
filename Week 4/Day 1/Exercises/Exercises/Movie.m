//
//  Movie.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.movieId = [coder decodeObjectForKey:@"movieId"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.movieDescription = [coder decodeObjectForKey:@"movieDescription"];
        self.rating = [coder decodeFloatForKey:@"rating"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.movieId forKey:@"movieId"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.movieDescription forKey:@"movieDescription"];
    [coder encodeFloat:self.rating forKey:@"rating"];
}

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
