//
//  TVShows.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "TVShow.h"

@implementation TVShow

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.tvShowId = [coder decodeObjectForKey:@"tvShowId"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.tvShowDescription = [coder decodeObjectForKey:@"tvShowDescription"];
        self.rating = [coder decodeFloatForKey:@"rating"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.tvShowId forKey:@"tvShowId"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.tvShowDescription forKey:@"tvShowDescription"];
    [coder encodeFloat:self.rating forKey:@"rating"];
}

- (id)copyWithZone:(NSZone *)zone
{
    TVShow *tvShowCopy = [[[self class] alloc] init];
    
    if (tvShowCopy) {
        tvShowCopy.tvShowId = [self.tvShowId copyWithZone:zone];
        tvShowCopy.title = [self.title copyWithZone:zone];
        tvShowCopy.tvShowDescription = [self.tvShowDescription copyWithZone:zone];
        tvShowCopy.rating = self.rating;
    }
    
    return tvShowCopy;
}

#pragma mark - Equality

- (BOOL)isEqualToTVShow:(TVShow *)other {
    return [self.tvShowId isEqualToString:other.tvShowId] && [self.title isEqualToString:other.title];
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToTVShow:other];
}

- (NSUInteger)hash
{
    return [_tvShowId hash];
}

@end
