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
@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *asn;
@property (nonatomic, copy) NSString *continentCode;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *countryCode3;
@property (nonatomic, copy) NSString *dmaCode;
@property (nonatomic, copy) NSString *isp;

- (BOOL)isValid;

@end
