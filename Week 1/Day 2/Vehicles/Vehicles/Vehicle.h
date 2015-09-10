//
//  Vehicle.h
//  Vehicles
//
//  Created by Joan Romano on 9/7/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property (nonatomic) NSUInteger modelYear;
@property (nonatomic) NSUInteger numberOfWheels;

@property (copy, nonatomic) NSString *powerSource;
@property (copy, nonatomic) NSString *brandName;
@property (copy, nonatomic) NSString *modelName;

@property (copy, nonatomic) NSString *gear;

+ (instancetype)vehicleWithModelYear:(NSUInteger)modelYear
                      numberOfWheels:(NSUInteger)numberofWheels
                         powerSource:(NSString *)powerSource
                           brandName:(NSString *)brandName
                           modelName:(NSString *)modelName;


- (instancetype)initWithModelYear:(NSUInteger)modelYear
                   numberOfWheels:(NSUInteger)numberofWheels
                      powerSource:(NSString *)powerSource
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName;

- (NSString *)goForward;
- (NSString *)goBackward;
- (NSString *)stop;
- (NSString *)makeNoise;
- (NSString *)changeGear:(NSString *)gear;
- (NSString *)turn:(NSInteger)degrees;

- (NSString *)vehicleTitleString;
- (NSString *)vehicleDetailsString;

@end
