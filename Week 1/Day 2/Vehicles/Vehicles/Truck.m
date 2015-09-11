//
//  Truck.m
//  Vehicles
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Truck.h"

@implementation Truck

#pragma mark - Override Methods

- (NSString *)goForward {
    return [NSString stringWithFormat:@"%@\n%@\n%@", [self start], [self changeGear:@"D"], @"Depress the gas pedal"];
}

- (NSString *)goBackward {
    return [NSString stringWithFormat:@"%@\n%@\n%@", [self start], [self changeGear:@"R"], @"Check your rear view mirror and depress the gas pedal"];
}

- (NSString *)stop {
    return [NSString stringWithFormat:@"%@\n%@", @"Depress break", [self changeGear:@"N"]];
}

@end
