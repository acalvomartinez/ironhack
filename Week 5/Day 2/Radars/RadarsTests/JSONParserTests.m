//
//  JSONParserTests.m
//  Radars
//
//  Created by Toni on 07/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONParser.h"

#import "StubFileUtil.h"

@interface ContextMock : NSManagedObjectContext
- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName;
@end

@implementation ContextMock : NSManagedObjectContext
- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName {
    return nil;
}
@end


@interface JSONParserTests : XCTestCase

@end

@implementation JSONParserTests

- (void)setup {
    
}

- (void)testJSONParserShouldReturnNilWhenPassedAnEmptyJSONString {

    ContextMock *mockContext = [[ContextMock alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSArray<Radar *> *radars = [JSONParser parseJSONString:@"" usingContext:mockContext];
    
    XCTAssertNil(radars);
}


- (void)testJSONParserShouldReturnOneRadarWhenPassedAnJSONStringWithOneRadar {
    
    ContextMock *mockContext = [[ContextMock alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSString *stub = [StubFileUtil loadJSONStubFileNamed:@"OneRadarResultStub"];
    
    NSArray<Radar *> *radars = [JSONParser parseJSONString:stub usingContext:mockContext];
    
    XCTAssertNotNil(radars);
    XCTAssertEqual(1, radars.count);
    //XCTAssertEqualObjects(@"jedi@group6.net", radars[0].user);
}


@end
