//
//  GeoIPServiceProtocol.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoIP;

typedef void(^GeoIPArrayCompletionBlock)(NSArray <NSString *> *);
typedef void(^GeoIPErrorBlock)(NSError *);

@protocol GeoIPServiceProtocol <NSObject>

@required

- (void)geoIPsInDirections:(NSArray *)directions
               completion:(GeoIPArrayCompletionBlock)completionBlock
                  onError:(GeoIPErrorBlock)errorBlock;

@optional


@end
