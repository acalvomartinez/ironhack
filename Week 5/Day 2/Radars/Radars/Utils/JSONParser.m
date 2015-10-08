//
//  JSONParser.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "JSONParser.h"

#import "Radar.h"

@implementation JSONParser

+ (NSArray<Radar *> *)parseJSONString:(NSString *)jsonAsString usingContext:(NSManagedObjectContext *)context {
    
    NSData *data = [jsonAsString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    NSMutableArray<Radar *> *radars = [[NSMutableArray alloc] initWithCapacity:100];
    
    NSArray *jsonRadars = [jsonDictionary objectForKey:@"result"];
    
    for (NSDictionary *jsonRadar in jsonRadars) {
        NSString *user = [jsonRadar objectForKey:@"user"];
        NSString *title = [jsonRadar objectForKey:@"title"];
        
        Radar *radar = [Radar radarWithUser:user andTitle:title inContext:context];
        
        if (radar) {
            [radars addObject:radar];
        }
    }
    
    return radars;
}

@end
