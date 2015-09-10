//
//  Motorcycle.h
//  Vehicles
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Vehicle.h"

@interface Motorcycle : Vehicle

+ (instancetype)motorcycleWithModelYear:(NSUInteger)modelYear
                              brandName:(NSString *)brandName
                              modelName:(NSString *)modelName
                            engineNoise:(NSString *)engineNoise;

- (instancetype)initWithModelYear:(NSUInteger)modelYear
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName
                      engineNoise:(NSString *)engineNoise;

@property (copy, nonatomic) NSString *engineNoise;

@end
