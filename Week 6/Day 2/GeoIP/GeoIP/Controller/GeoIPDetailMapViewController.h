//
//  GeoIPMapViewController.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotatingViewController.h"

@class GeoIP;

@interface GeoIPDetailMapViewController : RotatingViewController  

@property (nonatomic, strong) GeoIP *geoIP;

@end
