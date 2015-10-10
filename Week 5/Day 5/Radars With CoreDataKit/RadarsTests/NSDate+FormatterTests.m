//
//  NSDate+FormatterTests.m
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSDate+Formatter.h"

@interface NSDate_FormatterTests : XCTestCase

@end

@implementation NSDate_FormatterTests


- (void)testThatConvertToStringToDateWithAGivenValidFormat {
    NSString *dateString = @"2015-10-06 15:13:13.620410";
    
    NSDate *sut = [NSDate dateWithString:dateString andDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSSSSSS"];
    
    XCTAssertNotNil(sut);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:sut];
    
    XCTAssertEqual(dateComponents.day, 6);
    XCTAssertEqual(dateComponents.year, 2015);
    XCTAssertEqual(dateComponents.month, 10);
    XCTAssertEqual(dateComponents.hour, 15);
    XCTAssertEqual(dateComponents.minute, 13);
}

- (void)testThatConvertToStringToDateWithAnotherGivenValidFormat {
    NSString *dateString = @"08-Oct-2015 09:45 AM";
    
    NSDate *sut = [NSDate dateWithString:dateString andDateFormat:@"dd-MMM-yyyy hh:mm a"];
    
    XCTAssertNotNil(sut);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:sut];
    
    XCTAssertEqual(dateComponents.day, 8);
    XCTAssertEqual(dateComponents.year, 2015);
    XCTAssertEqual(dateComponents.month, 10);
    XCTAssertEqual(dateComponents.hour, 9);
    XCTAssertEqual(dateComponents.minute, 45);
}

- (void)testThatConvertToStringToDateWithAGivenInvalidFormat {
    NSString *dateString = @"2015-10-06 15:13:13.620410";
    
    NSDate *sut = [NSDate dateWithString:dateString andDateFormat:@"MM-yyyy-dd HH:mm:ss.SSSSSSSSSS"];
    
    XCTAssertNil(sut);
}

@end
