//
//  JSONParser.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "JSONParser.h"

#import "RadarJSON.h"

#import "NSDate+Formatter.h"

@implementation JSONParser

+ (NSArray<RadarJSON *> *)parseJSONString:(NSString *)jsonAsString {
    
    NSData *data = [jsonAsString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    NSArray *jsonRadars = [jsonDictionary objectForKey:@"result"];
    
    if (jsonRadars.count == 0) {
        return nil;
    }
    
    NSMutableArray<RadarJSON *> *radars = [[NSMutableArray alloc] initWithCapacity:jsonRadars.count];
    
    for (NSDictionary *radarDictionary in jsonRadars) {
        RadarJSON *radar = [self radarJSONWithDictionary:radarDictionary];
        
        if (radar) {
            [radars addObject:radar];
        }
    }
    
    return radars;
}

+ (RadarJSON *)radarJSONWithDictionary:(NSDictionary *)dictionary {
    RadarJSON *radar = [[RadarJSON alloc] init];
    
    radar.classification = [dictionary objectForKey:@"classification"];
    radar.radarDescription = [dictionary objectForKey:@"description"];
    radar.radarId = [[dictionary objectForKey:@"id"] integerValue];
    radar.modified = [NSDate dateWithString:[dictionary objectForKey:@"modified"] andDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS"];
    radar.created = [NSDate dateWithString:[dictionary objectForKey:@"created"] andDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS"];
    radar.number = [dictionary objectForKey:@"number"];
    radar.originated = [NSDate dateWithString:[dictionary objectForKey:@"created"] andDateFormat:@"dd-MMM-yyyy hh:mm a"];
    radar.parent = [dictionary objectForKey:@"parent"];
    radar.product = [dictionary objectForKey:@"product"];
    radar.reproducible = [dictionary objectForKey:@"reproducible"];
    radar.productVersion = [dictionary objectForKey:@"product_version"];
    radar.status = [dictionary objectForKey:@"status"];
    radar.resolved = [dictionary objectForKey:@"resolved"];
    radar.title = [dictionary objectForKey:@"title"];
    radar.user = [dictionary objectForKey:@"user"];
    
    return radar;
}

@end
