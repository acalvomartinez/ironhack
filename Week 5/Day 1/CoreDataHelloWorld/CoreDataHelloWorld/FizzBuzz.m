//
//  FizzBuzz.m
//  CoreDataHelloWorld
//
//  Created by Toni on 05/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "FizzBuzz.h"

@implementation FizzBuzz

+ (NSString *)fizzBuzz:(NSUInteger)number {
    
    if ((number % 3 == 0) && (number % 5 == 0)) {
        return @"FizzBuzz";
    }
    
    if (number % 3 == 0) {
       return @"Fizz";
    }
    
    if (number % 5 == 0) {
        return @"Buzz";
    }
    
    return [NSString stringWithFormat:@"%lu", (unsigned long)number];
}

@end
