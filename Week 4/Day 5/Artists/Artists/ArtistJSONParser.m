//
//  ArtistJSONParser.m
//  Artists
//
//  Created by Toni on 10/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistJSONParser.h"

#import "Artist.h"
#import "NSDate+Formatter.h"

@implementation ArtistJSONParser

#pragma mark - Serializiation

+ (NSArray *)artistsFromJSONData:(NSData *)JSONData error:(NSError *)parseError{
    
    NSArray *JSONArray = [NSJSONSerialization JSONObjectWithData:JSONData
                                                         options:kNilOptions
                                                           error:&parseError];
    
    if (parseError) {
        return nil;
    }
    
    return [self artistsFromJSONArray:JSONArray];
}

+ (NSArray *)artistsFromJSONArray:(NSArray *)JSONArray {
    
    NSMutableSet *artists = [NSMutableSet new];
    
    for (NSDictionary *dictionary in JSONArray) {
        
        NSURL *imageURL = [NSURL URLWithString:dictionary[@"image_url"]];
        NSDate *startDate = [NSDate dateWithString:dictionary[@"start_day"]];
        NSUInteger artistId = [dictionary[@"id"] integerValue];
        
        Artist *artist = [Artist artistWithName:dictionary[@"name"]
                                longDescription:dictionary[@"description"]
                                          stage:dictionary[@"stage"]
                                       imageURL:imageURL
                                      startDate:startDate
                                       artistId:artistId];
        [artists addObject:artist];
    }
    
    return [artists allObjects];
    
}

@end
