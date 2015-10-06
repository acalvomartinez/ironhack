//
//  RadarTests.m
//  RadarTests
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CoreDataStack.h"
#import "Radar.h"

@interface RadarTests : XCTestCase
@property (nonatomic, strong) CoreDataStack *cds;
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation RadarTests

- (void)setUp {
    [super setUp];
    
    self.cds = [[CoreDataStack alloc] init];
    self.context = self.cds.managedObjectContext;
}

- (void)tearDown {
    self.cds = nil;
    self.context = nil;
    
    [super tearDown];
}

- (void)testCanInsertARadarWithValidData {
    
    Radar *sut = [NSEntityDescription insertNewObjectForEntityForName:[Radar description] inManagedObjectContext:self.context];
    
    sut.title = @"Title test";
    sut.user = @"toniconmac@gmail.com";
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
}

- (void)testCannotInsertARadarWithInvalidEmail {
    
    Radar *sut = [NSEntityDescription insertNewObjectForEntityForName:[Radar description] inManagedObjectContext:self.context];
    
    sut.title = @"Title test";
    sut.user = @"toniconmac";
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

- (void)testCannotInsertARadarWithInvalidTitle {
    
    Radar *sut = [NSEntityDescription insertNewObjectForEntityForName:[Radar description] inManagedObjectContext:self.context];
    
    sut.title = nil;
    sut.user = @"toniconmac@gmail.com";
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

- (void)testCanRemoveARadar {
    
    Radar *sut = [NSEntityDescription insertNewObjectForEntityForName:[Radar description] inManagedObjectContext:self.context];
    
    sut.title = @"Title test";
    sut.user = @"toniconmac@gmail.com";
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    [self.context deleteObject:sut];
    
    error = nil;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Radar description]];
    
    error = nil;
    NSArray<Radar *> *results = [self.context executeFetchRequest:fetchRequest error:&error];
    
    XCTAssertTrue(results.count == 0);
}

- (void)testCanFetchARadar {
    Radar *sut = [NSEntityDescription insertNewObjectForEntityForName:[Radar description] inManagedObjectContext:self.context];
    
    sut.title = @"Title test";
    sut.user = @"toniconmac@gmail.com";
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Radar description]];
    
    error = nil;
    NSArray<Radar *> *results = [self.context executeFetchRequest:fetchRequest error:&error];
    
    XCTAssertTrue(results.count == 1);
}

@end
