//
//  JSONParserTests.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONParser.h"
#import "RadarJSON.h"

#import "StubFileUtil.h"

@interface JSONParserTests : XCTestCase

@end

@implementation JSONParserTests

- (void)testJSONParserShouldReturnNilWhenPassedAnEmptyJSONString {
 
    NSArray<RadarJSON *> *radars = [JSONParser parseJSONString:@""];
    
    XCTAssertNil(radars);
}


- (void)testJSONParserShouldReturnOneRadarWhenPassedAnJSONStringWithOneRadar {
    
    NSString *stub = [StubFileUtil loadJSONStubFileNamed:@"OneRadarResultStub"];
    
    NSArray<RadarJSON *> *radars = [JSONParser parseJSONString:stub];
    
    XCTAssertNotNil(radars);
    XCTAssertEqual(1, radars.count);
    XCTAssertEqualObjects(@"jedi@group6.net", radars[0].user);
}

- (void)testJSONParserShouldReturnNilWhenPassedAnEmptyJSON {
    NSString *stub = [StubFileUtil loadJSONStubFileNamed:@"EmptyRadarResultStub"];
    
    NSArray<RadarJSON *> *radars = [JSONParser parseJSONString:stub];
    
    XCTAssertNil(radars);
}

- (void)testJSONParserShouldReturnOneRadarWhenPassedAnJSONStringWithTenRadars {
    
    NSString *stub = [StubFileUtil loadJSONStubFileNamed:@"TenRadarResultStub"];
    
    NSArray<RadarJSON *> *radars = [JSONParser parseJSONString:stub];
    
    XCTAssertNotNil(radars);
    XCTAssertEqual(10, radars.count);
    
}

@end
