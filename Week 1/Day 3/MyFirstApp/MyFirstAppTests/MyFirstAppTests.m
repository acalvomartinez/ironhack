//
//  MyFirstAppTests.m
//  MyFirstAppTests
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface MyFirstAppTests : XCTestCase

@property (strong, nonatomic) ViewController *vc;

@end

@implementation MyFirstAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.vc = [[ViewController alloc] init];
}

- (void)tearDown {
    self.vc = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatExecuteDoThings {
    
    [self.vc viewDidLoad];
    
    XCTAssert(self.vc.doThingsExecuted, @"Pass!");
    
}


@end
