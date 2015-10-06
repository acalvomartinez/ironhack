//
//  PersonTests.m
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CoreDataStack.h"
#import "Person.h"

@interface PersonTests : XCTestCase
@property (nonatomic, strong) CoreDataStack *cds;
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation PersonTests

- (void)setUp {
    self.cds = [[CoreDataStack alloc] init];
    self.context = self.cds.managedObjectContext;
}

- (void)tearDown {
    self.cds = nil;
    self.context = nil;
}

- (void)testCanInsertAPersonWithAValidName {
    
    Person *sut = (Person *)[NSEntityDescription insertNewObjectForEntityForName:[Person description]
                                                             inManagedObjectContext:self.context];
    
    XCTAssertEqualObjects(@"John Doe", sut.name);
    
    sut.name = @"Han Solo";
    
    XCTAssertEqualObjects(@"Han Solo", sut.name);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
}

- (void)testCannotInsertAPersonWithNilName {
    
    Person *sut = (Person *)[NSEntityDescription insertNewObjectForEntityForName:[Person description]
                                                          inManagedObjectContext:self.context];
    sut.name = nil;
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

- (void)testCanInsertAPersonWith255CharLongName {
    
    Person *sut = (Person *)[NSEntityDescription insertNewObjectForEntityForName:[Person description]
                                                          inManagedObjectContext:self.context];
    
    NSString *name = [@"" stringByPaddingToLength:255 withString:@"abc" startingAtIndex:0];
    
    sut.name = name;
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
}

- (void)testCannotInsertAPersonWith256CharLongName {
    
    Person *sut = (Person *)[NSEntityDescription insertNewObjectForEntityForName:[Person description]
                                                          inManagedObjectContext:self.context];

    NSString *name = [@"" stringByPaddingToLength:256 withString:@"abc" startingAtIndex:0];
    
    sut.name = name;
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

@end
