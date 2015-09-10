//
//  Car.h
//  Vehicles
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Vehicle.h"

@interface Car : Vehicle

+ (instancetype)carWithModelYear:(NSUInteger)modelYear
                     powerSource:(NSString *)powerSource
                       brandName:(NSString *)brandName
                       modelName:(NSString *)modelName
                   numberOfDoors:(NSUInteger)numberOfDoors
                     convertible:(BOOL)convertible
                       hatchback:(BOOL)hatchback
                         sunroof:(BOOL)sunroof;

- (instancetype)initWithModelYear:(NSUInteger)modelYear
                      powerSource:(NSString *)powerSource
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName
                    numberOfDoors:(NSUInteger)numberOfDoors
                      convertible:(BOOL)convertible
                        hatchback:(BOOL)hatchback
                          sunroof:(BOOL)sunroof;

@property (nonatomic) NSUInteger numberOfDoors;
@property (nonatomic, getter=isConvertible) BOOL convertible;
@property (nonatomic, getter=hasHatchback) BOOL hatchback;
@property (nonatomic, getter=hasSunroof) BOOL sunroof;

@end
