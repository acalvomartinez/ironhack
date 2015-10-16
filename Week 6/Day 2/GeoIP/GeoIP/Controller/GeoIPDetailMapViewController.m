//
//  GeoIPMapViewController.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPDetailMapViewController.h"

#import <MapKit/MapKit.h>
#import "MapHelper.h"

#import "GeoIP.h"

@interface GeoIPDetailMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation GeoIPDetailMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.map removeAnnotations:[self.map annotations]];
}

- (void)setupMap {
    self.map.delegate = self;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    [self addDetailAnnotation];
}

- (void)addDetailAnnotation {
    if ([self.map annotations].count == 0) {
        self.title = [NSString stringWithFormat:@"%@ - %@",self.geoIP.country, self.geoIP.ip];
        
        [MapHelper centerMap:self.map onLatitude:self.geoIP.latitudeValue andLongitude:self.geoIP.longitudeValue rangeLat:100000 rangeLon:100000];
        [MapHelper addAnnotationToMap:self.map onLatitude:self.geoIP.latitudeValue andLongitude:self.geoIP.longitudeValue withTitle:self.geoIP.country];
        
    }
}


@end
