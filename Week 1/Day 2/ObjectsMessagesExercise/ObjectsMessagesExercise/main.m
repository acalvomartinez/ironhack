//
//  main.m
//  ObjectsMessagesExercise
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IronhackPerson.h"
#import "IronhackShoutingPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:2];
        [comps setMonth:2];
        [comps setYear:1975];
        NSDate *birthday = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        NSString *lastname = @"Solo";
        
        IronhackPerson *ironhacker = [[IronhackPerson alloc] initWithName:@"Han"
                                                                 lastname:lastname
                                                                 birthday:birthday];
        
        NSLog(@"%@",ironhacker);
        
        [ironhacker sayHello];
        [ironhacker saySomething:@"I'd shooted first!"];
        
        id badass = [IronhackShoutingPerson personWithName:@"Han"
                                                  lastname:@"Solo"
                                                  birthday:birthday];
        
        [badass saySomething:@"I'd shooted first!"];
        
        
        if ([badass isKindOfClass:[IronhackPerson class]]) {
            NSLog(@"I'm IronhackPerson");
        }
        
        IronhackPerson *nilPerson;
        
        if (nilPerson == nil) {
            NSLog(@"I'm nil IronhackPerson");
        }
        
        NSLog(@"Testing relationships");
        
        IronhackPerson *obi = [IronhackPerson personWithName:@"Obiwan" lastname:@"Kenobi" birthday:[NSDate date]];
        IronhackPerson *luke = [IronhackPerson personWithName:@"Luke" lastname:@"Skywalker" birthday:[NSDate date]];
        
        obi.padawan = luke;
        luke.master = obi;
        
        obi = nil;
        
        
        if (luke.master == nil) {
            NSLog(@"?");
        }
        
        
        NSLog(@"End of live");
        
    }
    return 0;
}
