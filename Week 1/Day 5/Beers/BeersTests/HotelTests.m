//
//  HotelTests.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Hotel.h"
#import "Person.h"

@interface HotelTests : XCTestCase

@property (nonatomic, strong) Hotel *hotel;

@end

@implementation HotelTests

- (void)setUp {
    [super setUp];
    
    self.hotel = [[Hotel alloc] init];
}

- (void)tearDown {
    
    self.hotel = nil;
    
    [super tearDown];
}

- (void)testThatCanCreateAHotel {
    XCTAssertNotNil(self.hotel,@"After creation hotel should not be nil");
}

- (void)testThatCanAddPersonToHotel {
    Person *client1 = [Person personWithName:@"Han Solo" address:@"Alderaan"];
    
    NSString *roomKey = [self.hotel addPerson:client1];
    
    XCTAssertEqualObjects(roomKey, @"Room0", @"First client should have the Room0 Key");
    
    Person *checkClient = [self.hotel personForRoom:roomKey];
    
    XCTAssertEqualObjects(checkClient.name, client1.name, @"Client in Room0 should have Han Solo");
    
}

- (void)testThatAddManyPersonToHotel {
    Person *client1 = [Person personWithName:@"Han Solo" address:@"Alderaan"];
    Person *client2 = [Person personWithName:@"Chewacca" address:@"Endor"];
    Person *client3 = [Person personWithName:@"Luke Skywalker" address:@"Tatoine"];
    
    [self.hotel addPerson:client1];
    [self.hotel addPerson:client2];
    [self.hotel addPerson:client3];
    
    XCTAssertEqual([self.hotel totalRooms], 3, @"Total rooms occupied must be 3");
}


@end
