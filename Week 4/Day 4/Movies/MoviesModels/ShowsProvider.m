//
//  ShowsProvider.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ShowsProvider.h"

#import "RequestManager.h"

#import <libextobjc/EXTScope.h>

#import "Show.h"

@implementation ShowsProvider

- (NSArray *)showsFromRemote
{
    return [self loadShowsFromRemote];
}

- (NSArray *)loadShowsFromRemote
{
    NSDictionary *JSONDictionary = [self showsJSONDictionaryFromRemote];
    
    NSError *parseError;
    return [MTLJSONAdapter modelsOfClass:[Show class] fromJSONArray:[JSONDictionary valueForKey:@"shows"] error:&parseError];
}

- (NSDictionary *)showsJSONDictionaryFromRemote
{
    NSURL *jsonURL = [NSURL URLWithString:@"https://ironhack4thweek.s3.amazonaws.com/shows.json"];
    NSData *seriesData = [NSData dataWithContentsOfURL:jsonURL];
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:seriesData options:NSJSONReadingMutableContainers error:&error];
    
    return JSONDictionary;
}

- (void)loadShowsDataFromRemoteOnSucces:(SuccessCompletionBlock)success failure:(FailureBlock)failure {

    RequestManager *manager = [[RequestManager alloc]init];
    
    NSString *urlString = @"https://ironhack4thweek.s3.amazonaws.com/shows.json";
    
    [manager getJSONWithURL:urlString success:^(id responseObject) {
        
        dispatch_queue_t json_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_async(json_queue, ^{
            NSDictionary *JSONDictionary = responseObject;
            
            NSMutableArray *results = [NSMutableArray arrayWithCapacity:[[JSONDictionary objectForKey:@"shows"] count]];
            
            for (NSDictionary *showDictionary in [JSONDictionary objectForKey:@"shows"]) {
                Show *show = [[Show alloc]init];
                show.showId = [showDictionary objectForKey:@"id"];
                show.showTitle = [showDictionary objectForKey:@"title"];
                show.showDescription = [showDictionary objectForKey:@"description"];
                show.posterURL = [NSURL URLWithString:[showDictionary objectForKey:@"posterURL"]];
                
                [results addObject:show];
            }
            
            NSError *parseError;
            
            if ([results count] != [[JSONDictionary objectForKey:@"shows"]count]) {
                parseError = [NSError errorWithDomain:@"com.ironhack.movies"
                                                 code:200
                                             userInfo:nil];
            }
            
            if (!parseError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success([results copy]);
                });
            } else {
                failure(parseError);
            }
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
