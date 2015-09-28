//
//  NSArray+RandomItem.m
//  Exercises
//
//  Created by Toni on 28/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "NSArray+RandomItem.h"

@implementation NSArray (RandomItem)

- (id)randomItem {
    NSUInteger randomIndex = arc4random_uniform(self.count);
    
    return [self objectAtIndex:randomIndex];
}

@end
