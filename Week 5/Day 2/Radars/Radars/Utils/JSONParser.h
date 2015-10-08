//
//  JSONParser.h
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RadarJSON;

@interface JSONParser : NSObject

+ (NSArray<RadarJSON *> *)parseJSONString:(NSString *)jsonAsString;

@end
