//
//  Artist.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Artist.h"

#import "NSString+Random.h"
#import "NSDate+Formatter.h"

@implementation Artist

+ (instancetype)artistWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate artistId:(NSUInteger)artistId; {
    return [[[self class] alloc] initWithName:name longDescription:longDescription stage:stage imageURL:imageURL startDate:startDate artistId:artistId];
}

- (instancetype)initWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate artistId:(NSUInteger)artistId; {
    
    if (self = [super init]) {
        _artistId = artistId;
        _name = name;
        _longDescription = longDescription;
        _stage = stage;
        _imageURL = imageURL;
        _startDate = startDate;
    }
    return self;
}

#pragma mark - NSCoding protocol

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.artistId = [aDecoder decodeIntegerForKey:@"artistId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.longDescription = [aDecoder decodeObjectForKey:@"longDescription"];
        self.stage = [aDecoder decodeObjectForKey:@"stage"];
        self.imageURL = [aDecoder decodeObjectForKey:@"imageURL"];
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.artistId forKey:@"artistId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.longDescription forKey:@"longDescription"];
    [aCoder encodeObject:self.stage forKey:@"stage"];
    [aCoder encodeObject:self.imageURL forKey:@"imageURL"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
}

#pragma mark - NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
    Artist *artistCopy = [[Artist alloc]init];
    
    if (artistCopy) {
        artistCopy.artistId = self.artistId;
        artistCopy.name = [self.name copyWithZone:zone];
        artistCopy.longDescription = [self.longDescription copyWithZone:zone];
        artistCopy.stage = [self.stage copyWithZone:zone];
        artistCopy.imageURL = [self.imageURL copyWithZone:zone];
        artistCopy.startDate = [self.startDate copyWithZone:zone];
    }
    return artistCopy;
}

+ (instancetype)randomArtist {
    return [Artist artistWithName:[NSString randomNameGenerator:20]
                  longDescription:[NSString randomNameGenerator:20]
                            stage:[NSString randomNameGenerator:10]
                         imageURL:[NSURL URLWithString:@"http://image.com/face.jpg"]
                        startDate:[NSDate date]
                         artistId:arc4random_uniform((u_int32_t)1000)];
}

#pragma mark - Equality

- (BOOL)isEqualToArtist:(Artist *)other {
    if (self.artistId != other.artistId) {
        return NO;
    }
    if (![self.name isEqualToString:other.name]) {
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self==object) {
        return YES;
    }
    if (![self isKindOfClass:[object class]]) {
        return NO;
    }
    return [self isEqualToArtist:object];
}

- (NSUInteger)hash {
    return _artistId;
}


@end
