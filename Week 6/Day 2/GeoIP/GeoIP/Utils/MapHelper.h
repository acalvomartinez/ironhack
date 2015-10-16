//
//  MapHelper.h
//  GeoIP
//
//  Created by Toni on 14/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface MapHelper : NSObject

+ (void)centerMap:(MKMapView *)map onLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude rangeLat:(CGFloat)rangeLat rangeLon:(CGFloat)rangeLon;

+ (void)addAnnotationToMap:(MKMapView *)map onLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitud withTitle:(NSString *)title;

+ (void)clearAnnotationsFromMAp:(MKMapView *)map;

@end
