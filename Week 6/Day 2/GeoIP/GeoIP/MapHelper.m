//
//  MapHelper.m
//  GeoIP
//
//  Created by Toni on 14/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "MapHelper.h"

#import "GeoIPMapAnnotation.h"

@implementation MapHelper

+ (void)centerMap:(MKMapView *)map onLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude rangeLat:(CGFloat)rangeLat rangeLon:(CGFloat)rangeLon{
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    [map setCenterCoordinate:centerCoordinate animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, rangeLat, rangeLon);
    MKCoordinateRegion adjustedRegion = [map regionThatFits:region];
    [map setRegion:adjustedRegion animated:YES];
}

+ (void)addAnnotationToMap:(MKMapView *)map onLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude withTitle:(NSString *)title {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    GeoIPMapAnnotation *pin = [[GeoIPMapAnnotation alloc] initWithCoordinate:coordinate andTitle:title];
    
    [map addAnnotation:pin];
}

+ (void)clearAnnotationsFromMAp:(MKMapView *)map {
    [map removeAnnotations:[map annotations]];
}


@end
