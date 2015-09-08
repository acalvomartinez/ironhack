//
//  main.m
//  OOP
//
//  Created by Toni on 07/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Person *senderPerson = [[Person alloc] initWithName:@"Chewacca"];
        
        senderPerson.flower = [[Flower alloc] init];
        senderPerson.flower.name = @"Rosa";
        
        Person *targetPerson = [[Person alloc] initWithName:@"Han"];
        
        BOOL result = [senderPerson sendMyFlowerTo:targetPerson];
        
        NSLog(@"%@", result ? @"Enviada!" : @"Nooooo");
        
        NSLog(@"%@ -> %@", senderPerson.flower, targetPerson.flower);
    }
    return 0;
}
