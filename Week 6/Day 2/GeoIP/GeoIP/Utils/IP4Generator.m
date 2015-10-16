//
//  IP4Generator.m
//  GeoIP
//
//  Created by Toni on 13/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "IP4Generator.h"

@implementation IP4Generator


+ (NSString *)generateRandomIP4 {
    return [NSString stringWithFormat:@"%d.%d.%d.%d",[self randomIP4Integer],[self randomIP4Integer],[self randomIP4Integer],[self randomIP4Integer]];
}

+ (NSArray *)genareteIP4ArrayWithCapacity:(NSUInteger)capacity {
    
    NSMutableArray *IP4Array = [NSMutableArray arrayWithCapacity:capacity];
    
    for (NSUInteger i = 0; i < capacity; i++) {
        [IP4Array addObject:[self generateRandomIP4]];
    }
    
    return IP4Array;
    
}


#pragma mark - Private

+ (NSUInteger)randomIP4Integer {
    return arc4random_uniform((u_int32_t)255);
}

@end
