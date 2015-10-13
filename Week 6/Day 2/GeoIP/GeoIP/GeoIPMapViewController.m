//
//  GeoIPMapViewController.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPMapViewController.h"

#import <MapKit/MapKit.h>

#import "GeoIP.h"
#import "GeoIPMapAnnotation.h"

@interface GeoIPMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@end

@implementation GeoIPMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMap];
}

- (void)setupMap {
    self.map.delegate = self;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    [self addDetailAnnotation];
}

- (void)addDetailAnnotation {
    if (self.geoIP) {
        self.title = [NSString stringWithFormat:@"%@ - %@",self.geoIP.country, self.geoIP.ip];
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([self.geoIP.latitude floatValue], [self.geoIP.longitude floatValue]);
        [self addAnnotationInCoordinate:centerCoordinate];
        [self.map setCenterCoordinate:centerCoordinate animated:YES];
        [self centerInPosition:centerCoordinate rangeLat:1000000 rangeLon:1000000];
    }
}

- (void)addAnnotationInCoordinate:(CLLocationCoordinate2D)coordinate {
    GeoIPMapAnnotation *pin = [[GeoIPMapAnnotation alloc] initWithCoordinate:coordinate];
    
    [self.map addAnnotation:pin];
}

- (void)centerInPosition:(CLLocationCoordinate2D)centerCoordinate rangeLat:(CGFloat)rangeLat rangeLon:(CGFloat)rangeLon {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, rangeLat, rangeLon);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
    [self.map setRegion:adjustedRegion animated:YES];
}

@end
