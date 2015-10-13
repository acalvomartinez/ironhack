//
//  GeoIPJSONMapper.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeoIP;
@class GeoIPJSON;

@interface GeoIPJSONMapper : NSObject

+ (NSArray<GeoIP *>*)mapGeoIPJSONs:(NSArray<GeoIPJSON *>*)jsonRadars
                         inContext:(NSManagedObjectContext *)context;

@end
