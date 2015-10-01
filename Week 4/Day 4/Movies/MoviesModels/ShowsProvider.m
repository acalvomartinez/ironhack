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
        
        NSDictionary *JSONDictionary = responseObject;
        
        NSError *parseError;
        NSArray *result = [MTLJSONAdapter modelsOfClass:[Show class] fromJSONArray:[JSONDictionary valueForKey:@"shows"] error:&parseError];
        
        if (!parseError) {
            success(result);
        } else {
            failure(parseError);
        }
        
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
