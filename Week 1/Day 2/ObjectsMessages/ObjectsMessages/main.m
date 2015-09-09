//
//  main.m
//  ObjectsMessages
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableString *myString1 = [NSMutableString new];
        NSMutableString *myString2 = myString1;
        [myString1 appendString:@"Hello, "];
        [myString1 appendString:@"World!"];
        NSString *s = myString2;
        NSLog(@"%@", s);
        
        NSString *myString3 = [MyObject myClassMethod:@"Hello," and:@"World!"];
        
        MyObject *object = [[MyObject alloc] init];
        int myInt = [object myInstanceMethod:40 andAlso:2];
        
        NSLog(@"myString3: %@ myInt: %d", myString3, myInt);
        
        //myInt = [object myOtherInstanceMethod:@40 andAlso:@2];
        
        myInt = [[object performSelector:@selector(myOtherInstanceMethod:andAlso:) withObject:@40 withObject:@2] intValue];
        
        NSLog(@"myInt: %d", myInt);
        
        [MyObject execute:^(NSString *str1, NSString *str2) {
            NSLog(@"%@, %@!",str1, str2);
        }];
        
        [MyObject execute:^(NSString *str1, NSString *str2) {
            NSLog(@"%@, %@!",str2, str1);
        }];
        
    }
    return 0;
}
