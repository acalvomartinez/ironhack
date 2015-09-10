//
//  Vehicle.m
//  Vehicles
//
//  Created by Joan Romano on 9/7/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Vehicle.h"

@interface Vehicle ()


@end

@implementation Vehicle

#pragma mark - Public Methods

+ (instancetype)vehicle {
    return [[self alloc] initWithModelYear:0
                            numberOfWheels:0
                               powerSource:nil
                                 brandName:nil
                                 modelName:nil];
}

+ (instancetype)vehicleWithModelYear:(NSUInteger)modelYear
                      numberOfWheels:(NSUInteger)numberofWheels
                         powerSource:(NSString *)powerSource
                           brandName:(NSString *)brandName
                           modelName:(NSString *)modelName {
    
    return [[self alloc] initWithModelYear:modelYear
                            numberOfWheels:numberofWheels
                               powerSource:powerSource
                                 brandName:brandName
                                 modelName:modelName];
}


- (instancetype)initWithModelYear:(NSUInteger)modelYear
                   numberOfWheels:(NSUInteger)numberofWheels
                      powerSource:(NSString *)powerSource
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName {
    if (self=[super init]) {
        _modelYear = modelYear;
        _numberOfWheels = numberofWheels;
        _powerSource = powerSource;
        _brandName = brandName;
        _modelName = modelName;
        
        _gear = @"N";
    }
    return self;
}

- (NSString *)goForward {
    return nil;
}
- (NSString *)goBackward {
    return nil;
}
- (NSString *)stop {
    return nil;
}
- (NSString *)makeNoise{
    return nil;
}

- (NSString *)changeGear:(NSString *)gear {
    self.gear = gear;
    return [NSString stringWithFormat:@"Change gear: %@", gear];
}

- (NSString *)turn:(NSInteger)degrees {
    
    return [NSString stringWithFormat:@"Turn: %ld", degrees%360];
}

- (NSString *)vehicleTitleString {
    return [NSString stringWithFormat:@"%@ %@ (%ld)", self.brandName, self.modelName, self.modelYear];
}

- (NSString *)vehicleDetailsString {
    return [NSString stringWithFormat:@"Brand: %@\nModel: %@\nYear: %ld\nPower Source: %@\nNum. Wheels: %ld", self.brandName, self.modelName, self.modelYear,self.powerSource, self.numberOfWheels];
}

@end
