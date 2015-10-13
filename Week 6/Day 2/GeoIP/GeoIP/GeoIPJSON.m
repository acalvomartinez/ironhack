//
//  GeoIPJSON.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPJSON.h"

@implementation GeoIPJSON

- (BOOL)isValid {
    return (self.country!=nil && self.latitude!=nil && self.longitude!=nil);
}
@end
