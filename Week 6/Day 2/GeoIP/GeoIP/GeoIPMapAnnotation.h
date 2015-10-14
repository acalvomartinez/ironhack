//
//  GeoIPMapAnnotation.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GeoIPMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title;

- (NSString *)title;

@end
