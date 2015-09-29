//
//  ShowsProvider.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ShowsProvider.h"

#import "Show.h"

@implementation ShowsProvider

- (NSArray *)showsFromRemote
{
    return [self loadShowsFromRemote];
}

- (NSArray *)loadShowsFromRemote
{
    NSMutableArray *shows = [NSMutableArray array];
    NSDictionary *JSONDictionary = [self showsJSONDictionaryFromRemote];
    
    for (NSDictionary *tvshowDictionary in [JSONDictionary valueForKey:@"shows"])
    {
        NSError *parseError;
        Show *showItem = [MTLJSONAdapter modelOfClass:[Show class] fromJSONDictionary:tvshowDictionary error:&parseError];
        if (parseError) {
            NSLog(@"%@",parseError);
        }
        [shows addObject:showItem];
    }
    
    return [shows copy];
}

- (NSDictionary *)showsJSONDictionaryFromRemote
{
    NSURL *jsonURL = [NSURL URLWithString:@"https://ironhack4thweek.s3.amazonaws.com/shows.json"];
    NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
    
    return JSONDictionary;
}

@end
