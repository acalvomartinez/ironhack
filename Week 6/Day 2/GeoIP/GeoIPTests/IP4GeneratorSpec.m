//
//  IP4GeneratorSpec.m
//  GeoIP
//
//  Created by Toni on 16/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//


#import <Kiwi/Kiwi.h>
#import <ObjectiveSugar/ObjectiveSugar.h>
#import "IP4Generator.h"

SPEC_BEGIN(IP4GeneratorSpec)

describe(@"When using IP4Generator objects in memory", ^{
    it(@"after creation it return a non-nil object", ^{
        NSString *sut = [IP4Generator generateRandomIP4];
        
        [[sut shouldNot] beNil];
    });
    
    it(@"should generate many elements in array", ^{
        NSArray *sut = [IP4Generator genareteIP4ArrayWithCapacity:10];
        
        [[sut shouldNot] beNil];
        [[@(sut.count) should] equal:@10];
        
        [@10 timesWithIndex:^(int index) {
            [[sut[index] shouldNot] beNil];
        }];
    });
    
    
});




SPEC_END