//
//  NSString+Fomatter.m
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

+ (instancetype)dateWithString:(NSString *)dateString andDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    return dateFromString;
}

- (NSString *)stringFromDateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *stringfromDate = [dateFormatter stringFromDate:self];
    
    return stringfromDate;
}

@end
