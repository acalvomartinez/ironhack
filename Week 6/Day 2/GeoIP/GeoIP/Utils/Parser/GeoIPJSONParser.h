//
//  GeoIPJSONParser.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoIPJSON;

typedef void(^GeoIPJSONParserErrorBlock)(NSError * );
typedef void(^GeoIPJSONParserCompletion)(NSArray<GeoIPJSON *> *);

@interface GeoIPJSONParser : NSObject

+ (void)parseJSONArray:(NSArray *)jsonArray
          onCompletion:(GeoIPJSONParserCompletion)completion
          onErrorBlock:(GeoIPJSONParserErrorBlock)errorBlock;

@end
