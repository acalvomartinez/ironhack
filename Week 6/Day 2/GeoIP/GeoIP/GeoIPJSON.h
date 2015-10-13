//
//  GeoIPJSON.h
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoIPJSON : NSObject

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *areaCode;
@property (nonatomic, strong) NSString *asn;
@property (nonatomic, strong) NSString *continentCode;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *countryCode3;
@property (nonatomic, strong) NSString *dmaCode;
@property (nonatomic, strong) NSString *isp;

- (BOOL)isValid;

@end
