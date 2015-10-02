//
//  Artist.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Artist.h"

#import "NSString+Random.h"

@implementation Artist

+ (instancetype)artistWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate {
    return [[[self class] alloc] initWithName:name longDescription:longDescription stage:stage imageURL:imageURL startDate:startDate];
}

- (instancetype)initWithName:(NSString *)name longDescription:(NSString *)longDescription stage:(NSString *)stage imageURL:(NSURL *)imageURL startDate:(NSDate *)startDate {
    
    if (self = [super init]) {
        _name = name;
        _longDescription = longDescription;
        _stage = stage;
        _imageURL = imageURL;
        _startDate = startDate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Artist *artistCopy = [[Artist alloc]init];
    
    if (artistCopy) {
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
                        startDate:[NSDate date]];
}

@end
