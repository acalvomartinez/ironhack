//
//  MyObject.h
//  ObjectsMessages
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MyBlock)(NSString *str1, NSString *str2);

@interface MyObject : NSObject

+ (NSString *)myClassMethod:(NSString *)str1 and:(NSString *)str2;

- (int)myInstanceMethod:(int)int1 andAlso:(int)int2;
- (NSNumber *)myOtherInstanceMethod:(NSNumber *)number1 andAlso:(NSNumber *)number2;

- (void)rockAndRollBaby:(id)sender;

+ (void)execute:(MyBlock)block;

@end
