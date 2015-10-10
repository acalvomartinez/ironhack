//
//  ArtistJSONParser.h
//  Artists
//
//  Created by Toni on 10/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistJSONParser : NSObject

+ (NSArray *)artistsFromJSONData:(NSData *)JSONData error:(NSError *)parseError;

@end
