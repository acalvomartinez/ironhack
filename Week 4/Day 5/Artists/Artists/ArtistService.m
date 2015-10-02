//
//  ArtistService.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistService.h"

#import "Artist.h"

#import "NSDate+Formatter.h"

static NSString * const kArtistJSONURL = @"https://ironhackartists.firebaseio.com/artists.json";

@implementation ArtistService

- (void)artistsWithCompletion:(void (^)(NSArray *))completion {
    NSURL *url = [NSURL URLWithString:kArtistJSONURL];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url
              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                  NSError *parseError;
                  NSArray *JSONArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                  
                  NSArray *artists = [self artistsFromJSONArray:JSONArray];
                  
                  completion(artists);
    }];
    
    [task resume];
    
}

- (NSArray *)artistsFromJSONArray:(NSArray *)JSONArray {
    
    NSMutableArray *artists = [NSMutableArray arrayWithCapacity:JSONArray.count];
    
    for (NSDictionary *dictionary in JSONArray) {
        
        NSURL *imageURL = [NSURL URLWithString:dictionary[@"image_url"]];
        NSDate *startDate = [NSDate dateWithString:dictionary[@"start_day"]];
        
        Artist *artist = [Artist artistWithName:dictionary[@"name"]
                                longDescription:dictionary[@"name"]
                                          stage:dictionary[@"name"]
                                       imageURL:imageURL
                                      startDate:startDate];
        [artists addObject:artist];
    }
    
    return [artists copy];
    
}

@end
