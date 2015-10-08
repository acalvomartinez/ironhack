//
//  RadarAPIWrapper.h
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RadarAPIWebServiceProtocol.h"

@interface RadarAPIWrapper : NSObject <RadarAPIWebServiceProtocol>

/**
 *  Method that fetches json radar data from internet
 *
 *  @param baseURL      NSString * with url
 *  @param completion   Completion Block
 *  @param onErrorBlock Error Block
 */

- (void)radarsWithBaseURL:(NSString * _Nonnull)baseURL
               completion:(void (^ _Nullable)(NSString * _Nullable))completion
                  onError:(void (^ _Nullable)(NSError * _Nullable))onErrorBlock;
@end
