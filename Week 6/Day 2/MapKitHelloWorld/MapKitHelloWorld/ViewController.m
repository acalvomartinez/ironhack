//
//  ViewController.m
//  MapKitHelloWorld
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CoreLocationHelper.h"
#import "MapPin.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic) CLLocationCoordinate2D lastPosition;

@end

#define CENTER_LATITUDE 37.386260
#define CENTER_LONGITUDE -5.992279

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLocationManager];
    [self setupMap];
    
}

- (void)setupLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)setupMap {
    self.map.delegate = self;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(CENTER_LATITUDE, CENTER_LONGITUDE);
    
    MapPin *pin = [[MapPin alloc] initWithCoordinate:centerCoordinate];
    
    [self.map addAnnotation:pin];
}

- (IBAction)centerButtonPressed:(id)sender {
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(CENTER_LATITUDE, CENTER_LONGITUDE);
    
    [self centerInPosition:centerCoordinate rangeLat:1000 rangeLon:1000];
}

- (void)centerInPosition:(CLLocationCoordinate2D)centerCoordinate rangeLat:(CGFloat)rangeLat rangeLon:(CGFloat)rangeLon {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, rangeLat, rangeLon);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
    [self.map setRegion:adjustedRegion animated:YES];
}

- (IBAction)sastButtonPressed:(id)sender {
    self.map.mapType = MKMapTypeSatellite;
}

- (IBAction)hybButtonPressed:(id)sender {
    self.map.mapType = MKMapTypeHybrid;
}

- (IBAction)norButtonPressed:(id)sender {
    self.map.mapType = MKMapTypeStandard;
}

- (IBAction)backButtonPressed:(id)sender {
    [self centerInPosition:self.lastPosition rangeLat:10000 rangeLon:10000];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - MapKit Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.lastPosition = userLocation.location.coordinate;
    
    self.locationLabel.text = [NSString stringWithFormat:@"you are in lat:%.4f lon:%.4f", self.map.centerCoordinate.latitude, self.map.centerCoordinate.longitude];
    
    [self centerInPosition:self.lastPosition rangeLat:100000 rangeLon:100000];
}


@end
