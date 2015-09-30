//
//  Counter.m
//  BlockTest
//
//  Created by Toni on 30/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "Counter.h"

@implementation Counter

- (void)countTo10000:(id)object selector:(SEL)selector
{
    for (NSInteger i=0; i < 10000; i++) {
        NSLog(@"%@",@(i));
    }
    
    [object performSelector:selector];
}

- (void)countTo10000WithCompletion:(void (^)(BOOL))completion {
    
    for (NSInteger i=0; i < 10000; i++) {
        NSLog(@"%@",@(i));
    }
    
    completion(YES);
}

@end
