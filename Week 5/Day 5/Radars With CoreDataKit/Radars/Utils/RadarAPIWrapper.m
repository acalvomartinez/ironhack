//
//  RadarAPIWrapper.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "RadarAPIWrapper.h"

@implementation RadarAPIWrapper

- (void)radarsWithBaseURL:(NSString * _Nonnull)baseURL
               completion:(void (^ _Nullable)(NSString * _Nullable))completion
                  onError:(void (^ _Nullable)(NSError * _Nullable))onErrorBlock {
    
    if (!baseURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            onErrorBlock == nil ? : onErrorBlock(nil);
        });
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{
                                            @"accept": @"application/json",
                                            @"content-type": @"text/json"
                                            };
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData * _Nullable data,
                                                            NSURLResponse * _Nullable response,
                                                            NSError * _Nullable error) {
                                            NSAssert([NSThread currentThread] != [NSThread mainThread], @"OMG!");
                                            if (!error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSString *stringData = [[NSString alloc] initWithData:data
                                                                                                 encoding:NSUTF8StringEncoding];
                                                    completion == nil ? : completion(stringData);
                                                });
                                            } else {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    onErrorBlock == nil ? : onErrorBlock(error);
                                                });
                                                
                                            }
    }];
    
    [task resume];
}

@end
