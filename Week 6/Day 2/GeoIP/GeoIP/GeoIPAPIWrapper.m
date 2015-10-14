//
//  GeoIPWrapper.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPAPIWrapper.h"

#import "GeoIPJSONParser.h"
#import "GeoIPJSONMapper.h"
#import "GeoIPJSON.h"

static NSString const *kGeoIPServiceURL = @"http://www.telize.com/geoip/";

typedef void(^GeoIPCompletionBlock)(NSString *);

@interface GeoIPAPIWrapper ()

@property (nonatomic, strong) dispatch_queue_t download_q;

@end

@implementation GeoIPAPIWrapper

- (void)geoIPsInDirections:(NSArray *)directions
                completion:(GeoIPArrayCompletionBlock)completionBlock
                   onError:(GeoIPErrorBlock)errorBlock {
    
    NSMutableArray *jsonGeoIPArray = [NSMutableArray arrayWithCapacity:[directions count]];
    
    for (NSString *ip in directions) {
        [self dowloadGeoIPDataIndirection:ip onCompletion:^(NSString *jsonGeoIP) {
            [jsonGeoIPArray addObject: jsonGeoIP];
            
            if ([jsonGeoIPArray count] == [directions count]) {
               completionBlock == nil ? : completionBlock(jsonGeoIPArray);
            }
        } onError:^(NSError *error) {
            errorBlock == nil ? : errorBlock(error);
        }];
    }
}

- (dispatch_queue_t)download_q {
    if (_download_q) {
        _download_q = dispatch_queue_create("com.ironhack.geoip.donwload", DISPATCH_QUEUE_CONCURRENT);
    }
    return _download_q;
}

- (void)dowloadGeoIPDataIndirection:(NSString *)ip
                       onCompletion:(GeoIPCompletionBlock)completion
                            onError:(GeoIPErrorBlock)error {
    
    if (!ip) {
        dispatch_async(dispatch_get_main_queue(), ^{
            error == nil ? : error(nil);
        });
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{
                                            @"accept": @"application/json",
                                            @"content-type": @"text/json"
                                            };
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kGeoIPServiceURL,ip]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            
                                            NSString *jsonStringData = [[NSString alloc] initWithData:data
                                                                                             encoding:NSUTF8StringEncoding];
                                            if (completion) {
                                                completion(jsonStringData);
                                            }
                                        }];
    [task resume];
}

@end
