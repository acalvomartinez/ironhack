//
//  IP4GeneratorTests.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IP4Generator.h"

@interface IP4GeneratorTests : XCTestCase

@end

@implementation IP4GeneratorTests

- (void)testThatGenerateAValidRandomIP4String {
    NSString *sut = [IP4Generator generateRandomIP4];
    
    // [0-255].[0-255].[0-255].[0-255]
    
    XCTAssertNotNil(sut);
    XCTAssertTrue(sut.length >= 7);
    
    NSArray *sutArray = [sut componentsSeparatedByString:@"."];
    
    for (NSString *ipStringNumber in sutArray) {
        NSUInteger ipInteger = [ipStringNumber integerValue];
        
        XCTAssertTrue(ipInteger >= 0 && ipInteger <=255);
    }
    
}

- (void)testThatGenerate5RandomIP4Strings {
    NSArray *sut = [IP4Generator genareteIP4ArrayWithCapacity:5];
    
    XCTAssertNotNil(sut);
    XCTAssertEqual([sut count], 5);
}

@end
