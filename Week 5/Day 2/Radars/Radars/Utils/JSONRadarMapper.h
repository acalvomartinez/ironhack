//
//  JSONRadarMapper.h
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class RadarJSON;
@class Radar;

@interface JSONRadarMapper : NSObject

+ (NSArray<Radar *>*)mapJSONRadars:(NSArray<RadarJSON *>*)jsonRadars inContext:(NSManagedObjectContext *)context;

@end
