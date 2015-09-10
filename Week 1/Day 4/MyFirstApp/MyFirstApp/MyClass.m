//
//  MyClass.m
//  MyFirstApp
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

-(instancetype)init{
    if (self=[super init]) {
        _name = @"Mierda tocha";
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@ has change", keyPath);
}

@end
