//
//  GeoIPWrapper.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeoIPServiceProtocol.h"


@interface GeoIPAPIWrapper : NSObject <GeoIPServiceProtocol>

- (void)geoIPsInDirections:(NSArray *)directions
                completion:(GeoIPArrayCompletionBlock)completionBlock
                   onError:(GeoIPErrorBlock)errorBlock;

@end
