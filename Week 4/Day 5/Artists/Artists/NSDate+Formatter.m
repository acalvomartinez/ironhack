//
//  NSDate+Formatter.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

+ (instancetype)dateWithString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"]; // 2015-06-12T22:45:00
    NSDate *dateFromString = [[NSDate alloc] init];

    dateFromString = [dateFormatter dateFromString:dateString];
    
    return dateFromString;
}

@end
