//
//  GeoIPJSONParser.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPJSONParser.h"

#import "GeoIPJSON.h"


@implementation GeoIPJSONParser

+ (void)parseJSONArray:(NSArray *)jsonArray
          onCompletion:(GeoIPJSONParserCompletion)completion
          onErrorBlock:(GeoIPJSONParserErrorBlock)errorBlock {
    
    if (!jsonArray) {
        NSError *error = [NSError errorWithDomain:@"com.ironhack.geoip" code:200 userInfo:nil];
        errorBlock(error);
        return;
    }
    
    NSMutableArray *geoIPs = [NSMutableArray arrayWithCapacity:jsonArray.count];
    
    for (NSString *jsonString in jsonArray) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
        if (error) {
            errorBlock(error);
        }
        
        GeoIPJSON *geoIPJSON = [self geoIPJSONFromDictionary:jsonDictionary];
        
        [geoIPs addObject:geoIPJSON];
    }
    
    if (completion) {
        completion(geoIPs);
    }
}

+ (GeoIPJSON *)geoIPJSONFromDictionary:(NSDictionary *)dictionary {
    GeoIPJSON *geoIPJSON = [[GeoIPJSON alloc] init];
    
    geoIPJSON.ip = [dictionary objectForKey:@"ip"];
    geoIPJSON.country = [dictionary objectForKey:@"country"];
    geoIPJSON.latitude = [dictionary objectForKey:@"latitude"];
    geoIPJSON.longitude = [dictionary objectForKey:@"longitude"];
    geoIPJSON.areaCode = [dictionary objectForKey:@"area_code"];
    geoIPJSON.asn = [dictionary objectForKey:@"asn"];
    geoIPJSON.continentCode = [dictionary objectForKey:@"continent_code"];
    geoIPJSON.countryCode = [dictionary objectForKey:@"country_code"];
    geoIPJSON.countryCode3 = [dictionary objectForKey:@"country_code3"];
    geoIPJSON.dmaCode = [dictionary objectForKey:@"dma_code"];
    geoIPJSON.isp = [dictionary objectForKey:@"isp"];
    
    return geoIPJSON;
}


@end
