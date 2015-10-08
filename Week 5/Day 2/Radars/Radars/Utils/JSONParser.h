//
//  JSONParser.h
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Radar.h"

@interface JSONParser : NSObject

+ (NSArray<Radar *> *)parseJSONString:(NSString *)jsonAsString usingContext:(NSManagedObjectContext *)context;

@end
