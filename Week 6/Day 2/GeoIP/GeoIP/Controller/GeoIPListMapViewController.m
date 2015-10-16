//
//  GeoIPListMapViewController.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPListMapViewController.h"

#import "GeoIP.h"
#import "GeoIPMapAnnotation.h"

#import <MapKit/MapKit.h>

#import "MapHelper.h"

typedef void(^GeoIPsMapCompletionBlock)(NSArray *);
typedef void(^GeoIPsMapErrorBlock)(NSError *);

@interface GeoIPListMapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) NSArray *geoIPs;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation GeoIPListMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMap];
    
    self.title = @"GeoIP Map";
    
    [self updateMapList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMapList) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
}

- (void)setupMap {
    self.map.delegate = self;
}


- (void)updateMapList {
    __weak typeof(self) weakSelf = self;
    
    [self loadGeoIPsOnCompletion:^(NSArray *geoIPs) {
        weakSelf.geoIPs = geoIPs;
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadGeoIPsOnCompletion:(GeoIPsMapCompletionBlock)completion onError:(GeoIPsMapErrorBlock)errorBlock {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[GeoIP entityName]];
    NSError *error;
    NSArray *geoIPs = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        errorBlock == nil ? : errorBlock(error);
        return;
    }
    
    completion == nil ? : completion(geoIPs);
}

- (void)setGeoIPs:(NSArray *)geoIPs {
    [MapHelper clearAnnotationsFromMAp:self.map];
    
    for (GeoIP *geoIP in geoIPs) {
        [MapHelper addAnnotationToMap:self.map onLatitude:geoIP.latitudeValue andLongitude:geoIP.longitudeValue withTitle:geoIP.country];
    }
    
    _geoIPs = geoIPs;
}

#pragma mark - MapKit Delegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    
    return annotationView;
}


@end
