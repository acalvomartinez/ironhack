//
//  KiwiTests.m
//  GeoIP
//
//  Created by Toni on 16/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GeoIPJSON.h"

SPEC_BEGIN(GeoIPJson)

describe(@"When using GeoIPJSON objects in memory", ^{
    it(@"after creation it return a non-nil object", ^{
        GeoIPJSON *sut = [[GeoIPJSON alloc] init];
        
        [[sut shouldNot] beNil];
    });
    
    
    it (@"should store the IP address", ^{
        GeoIPJSON *sut = [[GeoIPJSON alloc] init];
        
        sut.ip = @"10.10.10.10";
        
        [[sut.ip shouldNot] beNil];
        [[sut.ip should] equal:@"10.10.10.10"];
    });
    
    
});




SPEC_END