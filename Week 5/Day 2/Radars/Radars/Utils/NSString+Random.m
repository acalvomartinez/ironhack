//
//  NSString+Random.m
//  Radars
//
//  Created by Toni on 06/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *)randomTitleGenerator:(NSInteger)characterLength
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:characterLength];
    
    for (int i = 0; i < characterLength; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (NSString *)randomEmailGenerator {
    NSString *email = [NSString stringWithFormat:@"%@@%@.%@", [NSString randomTitleGenerator:5], [NSString randomTitleGenerator:5],[NSString randomTitleGenerator:3]];
    
    return [email lowercaseString];

}

@end
