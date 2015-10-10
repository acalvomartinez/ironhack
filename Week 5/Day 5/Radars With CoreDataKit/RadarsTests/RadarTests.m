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

#import "NSManagedObjectContext+ACMInsertManagedObject.h"

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
    Radar *sut = [self insertExampleRadarWithTitle:@"Title test" user:@"toniconmac@gmail.com"];
    
    XCTAssertNotNil(sut);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
}

- (void)testCannotInsertARadarWithInvalidEmail {
    
    Radar *sut = [self insertExampleRadarWithTitle:@"Title test" user:@"toniconmac"];

    XCTAssertNotNil(sut);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

- (void)testCannotInsertARadarWithInvalidTitle {
    
    Radar *sut = [self insertExampleRadarWithTitle:nil user:@"toniconmac@gmail.com"];

    XCTAssertNotNil(sut);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNotNil(error);
}

- (void)testCanRemoveARadar {
    
    Radar *sut = [self insertExampleRadarWithTitle:@"Title test" user:@"toniconmac@gmail.com"];
 
    XCTAssertNotNil(sut);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    [self.context deleteObject:sut];
    
    error = nil;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    
    error = nil;
    NSUInteger countAllRadars = [self countAllRadars:&error];
    XCTAssertNil(error);
    
    XCTAssertTrue(countAllRadars == 0);
}

- (void)testCanFetchARadar {
    Radar *sut = [self insertExampleRadarWithTitle:@"Title test" user:@"toniconmac@gmail.com"];
    
    XCTAssertNotNil(sut);
    
    NSError *error;
    [self.context save:&error];
    
    XCTAssertNil(error);
    
    error = nil;
    NSUInteger countAllRadars = [self countAllRadars:&error];
    XCTAssertNil(error);
    
    XCTAssertTrue(countAllRadars == 1);
}

- (Radar *)insertExampleRadarWithTitle:(NSString *)title user:(NSString *)user {
    Radar *sut = (Radar *)[self.context insertNewObjectForEntityForName:[Radar description]];
    sut.title = title;
    sut.user = user;
    return sut;
}

- (NSUInteger)countAllRadars:(NSError **)radarError {
    NSUInteger radarCount;
    
    NSFetchRequest *fetchRequest = [self fetchRequestAllRadars];
    
    NSError *error;
    radarCount = [[self.context executeFetchRequest:fetchRequest error:&error] count];
    
    *radarError = error;
    
    return radarCount;
}

- (NSFetchRequest *)fetchRequestAllRadars {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Radar description]];
    return fetchRequest;
}

@end
