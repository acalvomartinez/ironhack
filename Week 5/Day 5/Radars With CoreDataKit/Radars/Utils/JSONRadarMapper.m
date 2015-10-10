//
//  JSONRadarMapper.m
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "JSONRadarMapper.h"

#import "Radar.h"
#import "RadarJSON.h"

#import <CoreDataKit/NSManagedObjectContext+ACMInsertManagedObject.h>

@implementation JSONRadarMapper

+ (NSArray<Radar *>*)mapJSONRadars:(NSArray<RadarJSON *>*)jsonRadars inContext:(NSManagedObjectContext *)context {
    
    NSMutableArray<Radar *> *radars = [NSMutableArray arrayWithCapacity:jsonRadars.count];
    
    for (RadarJSON *radarJSON in jsonRadars) {
        Radar *radar = [Radar radarWithUser:radarJSON.user andTitle:radarJSON.title product:radarJSON.product productVersion:radarJSON.productVersion inContext:context];
       
        [radars addObject:radar];
    }
    
    NSError *error;
    [context save:&error];
    if (error) {
        return nil;
    }
    
    return radars;
}

@end
