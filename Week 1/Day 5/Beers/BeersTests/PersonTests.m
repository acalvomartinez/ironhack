//
//  PersonTests.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Person.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCanCreateAPerson {
    
    Person *person = [[Person alloc] init];
    
    XCTAssertNotNil(person,@"After creation person should not be nil");
    XCTAssertEqualObjects(person.name, nil, @"After creation person name should be nil");
    XCTAssertEqual(person.age, 0,@"After creation person age should be 0");
}

- (void)testCanCreateAPersonWithName {
    
    Person *anotherPerson = [[Person alloc] initWithName:@"Toni"];
    
    XCTAssertEqualObjects(anotherPerson.name, @"Toni", @"After creation person name should be Toni");
}

- (void)testCanCreateAPersonWithNameAndAddress {
    
    Person *anotherPerson = [[Person alloc] initWithName:@"Toni" address:@"Conde de Torralba"];
    
    XCTAssertEqualObjects(anotherPerson.name, @"Toni", @"After creation person name should be Toni");
    XCTAssertEqualObjects(anotherPerson.address, @"Conde de Torralba", @"After creation person address should be Conde de Torralba");
}

- (void)testCanCreateAPersonWithNameAddressAndAge {
    
    Person *anotherPerson = [[Person alloc] initWithName:@"Toni" address:@"Conde de Torralba" age:40];
    
    XCTAssertEqualObjects(anotherPerson.name, @"Toni", @"After creation person name should be Toni");
    XCTAssertEqualObjects(anotherPerson.address, @"Conde de Torralba", @"After creation person address should be Conde de Torralba");
    XCTAssertEqual(anotherPerson.age, 40, @"After creation person age should be 40");
}

- (void)testCanCreateAPersonWithClassMethod {
    
    Person *anotherPerson = [Person personWithName:@"Toni" address:@"Conde de Torralba"];
    
    XCTAssertEqualObjects(anotherPerson.name, @"Toni", @"After creation person name should be Toni");
    XCTAssertEqualObjects(anotherPerson.address, @"Conde de Torralba", @"After creation person address should be Conde de Torralba");
    XCTAssertEqual(anotherPerson.age, 0, @"After creation person age should be default value");
}


@end
