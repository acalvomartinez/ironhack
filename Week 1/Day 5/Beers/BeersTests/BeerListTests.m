//
//  BeerListTests.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BeerList.h"
#import "Beer.h"

@interface BeerListTests : XCTestCase

@end

@implementation BeerListTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testInitBeers {
    BeerList *beers = [[BeerList alloc] init];
    
    XCTAssertEqual([beers totalBeers], 0, @"After creation the total count of beers should be 0");
}

- (void)testInitProperlyWithKVC {
    BeerList *beers = [[BeerList alloc] init];
    
    NSNumber *totalBeers = [beers valueForKey:@"totalBeers"];
    
    XCTAssertNotNil(totalBeers, @"KVC should give us an not nil object");
    XCTAssertEqual([totalBeers integerValue], 0, @"After creation the total count of beers should be 0");
}

- (void)testThatABeerIsAdded {
    BeerList *beers = [[BeerList alloc] init];
    
    XCTAssertEqual([beers totalBeers], 0, @"After creation the total count of beers should be 0");
    
    Beer *estrella = [Beer beerWithName:@"Estrella" color:@"Blonde" grade:4];
    
    [beers addBeer:estrella];
    XCTAssertEqual([beers totalBeers], 1, @"After add a beer the total count of beers should be 1");
}

- (void)testThat1000BeersAreAdded {
    BeerList *beers = [[BeerList alloc] init];
    
    for (NSUInteger i = 0; i < 1000; i++) {
        NSString *beerName = [NSString stringWithFormat:@"Beer%lu", i];
        Beer *beer = [Beer beerWithName:beerName color:@"Blonde" grade:4];
        
        [beers addBeer:beer];
    }
    
    XCTAssertEqual([beers totalBeers], 1000, @"After add 1000 beers the total count of beers should be 1000");
}


- (void)testThatABeerIsRemoved {
    BeerList *beers = [[BeerList alloc] init];
    
    Beer *estrella = [Beer beerWithName:@"Estrella" color:@"Blonde" grade:4];
    [beers addBeer:estrella];
    
    Beer *mahou = [Beer beerWithName:@"Mahou" color:@"Blonde" grade:4];
    [beers addBeer:mahou];
    
    XCTAssertEqual([beers totalBeers], 2, @"After add 2 beers the total count of beers should be 2");
    
    [beers removeBeer:estrella];
    
    XCTAssertEqual([beers totalBeers], 1, @"After remove a beera the total count of beers should be 1");
}

- (void)testThat100BeersAreAddedAndChecked {
    BeerList *beers = [[BeerList alloc] init];
    
    for (NSUInteger i = 0; i < 100; i++) {
        NSString *beerName = [NSString stringWithFormat:@"Beer%lu", i];
        Beer *beer = [Beer beerWithName:beerName color:@"Blonde" grade:4];
        
        [beers addBeer:beer];
    }
    
    XCTAssertEqual([beers totalBeers], 100, @"After add 100 beers the total count of beers should be 100");
    
    NSArray *allBeers = [beers allBeers];
    
    for (NSUInteger i = 0; i < 100; i++) {
        Beer *beer = [allBeers objectAtIndex:i];
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",i];
        
        XCTAssertEqualObjects(beer.name, testName);
    }
    
    NSUInteger i = 0;
    
    for (Beer *beer in allBeers) {
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",i];
        
        XCTAssertEqualObjects(beer.name, testName);
        
        i++;
    }
    
    [allBeers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Beer *beer = (Beer *)obj;
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",idx];
        
        XCTAssertEqualObjects(beer.name, testName);
    }];
    
    
}

- (void)testThat100BeersAreAddedAndCheckedInKVC {
    BeerList *beers = [[BeerList alloc] init];
    
    for (NSUInteger i = 0; i < 100; i++) {
        NSString *beerName = [NSString stringWithFormat:@"Beer%lu", i];
        Beer *beer = [[Beer alloc] init];
        [beer setValue:beerName forKey:@"name"];
        
        [beers addBeer:beer];
    }
    
    XCTAssertEqual([beers totalBeers], 100, @"After add 100 beers the total count of beers should be 100");
    
    NSArray *allBeers = [beers allBeers];
    
    for (NSUInteger i = 0; i < 100; i++) {
        Beer *beer = [allBeers objectAtIndex:i];
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",i];
        
        XCTAssertEqualObjects([beer valueForKey:@"name"], testName);
    }
    
    NSUInteger i = 0;
    
    for (Beer *beer in allBeers) {
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",i];
        
        XCTAssertEqualObjects([beer valueForKey:@"name"], testName);
        
        i++;
    }
    
    [allBeers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Beer *beer = (Beer *)obj;
        
        NSString *testName = [NSString stringWithFormat:@"Beer%lu",idx];
        
        XCTAssertEqualObjects([beer valueForKey:@"name"], testName);
    }];
    
    
}


@end
