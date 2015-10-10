//
//  NSString+Fomatter.h
//  Radars
//
//  Created by Toni on 08/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

+ (instancetype)dateWithString:(NSString *)stringDate andDateFormat:(NSString *)dateFormat;

- (NSString *)stringFromDateWithDateFormat:(NSString *)dateFormat;


@end
