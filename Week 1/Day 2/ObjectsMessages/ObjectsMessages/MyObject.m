//
//  MyObject.m
//  ObjectsMessages
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

+ (NSString *)myClassMethod:(NSString *)str1 and:(NSString *)str2 {
    return [NSString stringWithFormat:@"%@ %@",str1,str2];
}

+ (void)execute:(MyBlock)block {
    block(@"Hello", @"World");
}

- (int)myInstanceMethod:(int)int1 andAlso:(int)int2 {
    return int1+int2;
}

- (NSNumber *)myOtherInstanceMethod:(NSNumber *)number1 andAlso:(NSNumber *)number2 {
    return @([number1 intValue] + [number2 intValue]);
}

- (void)rockAndRollBaby:(id)sender {
    
}


@end
