//
//  GeoIPCell.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "GeoIPCell.h"

#import "GeoIP.h"

@interface GeoIPCell ()
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLonLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@end

@implementation GeoIPCell

- (void)setGeoIP:(GeoIP *)geoIP {
    self.countryLabel.text = geoIP.country;
    //self.latLonLabel.text = [NSString stringWithFormat:@"%.2f, %.2f", [geoIP.latitude floatValue], [geoIP.longitude floatValue]];
    self.latLonLabel.text = @"";
    self.ipLabel.text = geoIP.ip;
    
    _geoIP = geoIP;
}

@end
