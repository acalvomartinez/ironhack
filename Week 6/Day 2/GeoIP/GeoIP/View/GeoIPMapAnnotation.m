//
//  GeoIPMapAnnotation.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPMapAnnotation.h"

@interface GeoIPMapAnnotation ()

@property (nonatomic, copy, readwrite) NSString *title;

@end

@implementation GeoIPMapAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _title;
}

@end
