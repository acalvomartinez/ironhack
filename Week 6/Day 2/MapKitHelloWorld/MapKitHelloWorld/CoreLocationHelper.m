//
//  CoreLocationHelper.m
//  MapKitHelloWorld
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "CoreLocationHelper.h"

@implementation CoreLocationHelper

+ (BOOL)isLocationServiceAuthorizedByUser {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    }
    
    return NO;
}

@end
