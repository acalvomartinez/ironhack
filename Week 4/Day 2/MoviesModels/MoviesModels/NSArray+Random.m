//
//  NSArray+Random.m
//  MoviesModels
//
//  Created by Joan Romano on 9/27/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (id)mm_randomObject
{
    id randomObject = [self count] ? self[arc4random_uniform((u_int32_t)[self count])] : nil;
    return randomObject;
}

@end
