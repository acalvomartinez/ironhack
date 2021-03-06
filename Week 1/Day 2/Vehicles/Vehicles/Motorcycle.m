//
//  Motorcycle.m
//  Vehicles
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Motorcycle.h"

@implementation Motorcycle


+ (instancetype)motorcycleWithModelYear:(NSUInteger)modelYear
                              brandName:(NSString *)brandName
                              modelName:(NSString *)modelName
                            engineNoise:(NSString *)engineNoise {
    return [[self alloc] initWithModelYear:modelYear
                                 brandName:brandName
                                 modelName:modelName
                               engineNoise:engineNoise];
}

- (instancetype)initWithModelYear:(NSUInteger)modelYear
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName
                      engineNoise:(NSString *)engineNoise {
    if (self = [super initWithModelYear:modelYear
                         numberOfWheels:2
                            powerSource:@"Gas Engine"
                              brandName:brandName
                              modelName:modelName]) {
        _engineNoise = engineNoise;
    }
    return self;
}

- (NSString *)makeNoise{
    return self.engineNoise;
}

#pragma mark - Override Methods

- (NSString *)goForward {
    return [NSString stringWithFormat:@"%@\n%@", [self start], @"Turn the gas handgrip"];
}

- (NSString *)goBackward {
    return [NSString stringWithFormat:@"%@\n%@", [self turn:180], @"Turn the gas handgrip"];
}

- (NSString *)stop {
    return [NSString stringWithFormat:@"%@", @"Pull the break"];
}

- (NSString *)vehicleDetailsString {
    NSString *superDetail = [super vehicleDetailsString];
    
    return [NSString stringWithFormat:@"%@\nEngine Noise: %@", superDetail, self.engineNoise];
}

@end
