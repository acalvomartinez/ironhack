//
//  GeoIPJSONMapper.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPJSONMapper.h"

#import "GeoIP.h"
#import "GeoIPJSON.h"

@implementation GeoIPJSONMapper


+ (NSArray<GeoIP *> *)mapGeoIPJSONs:(NSArray<GeoIPJSON *> *)jsonGeoIPs
                          inContext:(NSManagedObjectContext *)context {
    
    NSMutableArray<GeoIP *> *geoIPs = [NSMutableArray arrayWithCapacity:jsonGeoIPs.count];
    
    for (GeoIPJSON *geoIPJSON in jsonGeoIPs) {
        if ([geoIPJSON isValid]) {
            GeoIP *geoIP = [GeoIP geoIPWithCountry:geoIPJSON.country
                                                ip:geoIPJSON.ip
                                          latitude:geoIPJSON.latitude
                                         longitude:geoIPJSON.longitude
                                         inContext:context];
            
            [geoIPs addObject:geoIP];
        }

    }
    
    NSError *error;
    [context save:&error];
    if (error) {
        return nil;
    }
    
    return geoIPs;
}

@end
