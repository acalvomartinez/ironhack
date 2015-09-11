//
//  Car.m
//  Vehicles
//
//  Created by Toni on 10/09/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import "Car.h"

@interface Car ()

@property (strong, nonatomic) NSArray *randomNoise;

@end

@implementation Car

#pragma mark - Public Methods

+ (instancetype)carWithModelYear:(NSUInteger)modelYear
                     powerSource:(NSString *)powerSource
                       brandName:(NSString *)brandName
                       modelName:(NSString *)modelName
                   numberOfDoors:(NSUInteger)numberOfDoors
                     convertible:(BOOL)convertible
                       hatchback:(BOOL)hatchback
                         sunroof:(BOOL)sunroof{
    
    return [[self alloc] initWithModelYear:modelYear
                               powerSource:powerSource
                                 brandName:brandName
                                 modelName:modelName
                             numberOfDoors:numberOfDoors
                               convertible:convertible
                                 hatchback:hatchback
                                   sunroof:sunroof];
}

- (instancetype)initWithModelYear:(NSUInteger)modelYear
                      powerSource:(NSString *)powerSource
                        brandName:(NSString *)brandName
                        modelName:(NSString *)modelName
                    numberOfDoors:(NSUInteger)numberOfDoors
                      convertible:(BOOL)convertible
                        hatchback:(BOOL)hatchback
                          sunroof:(BOOL)sunroof{
    
    if (self = [super initWithModelYear:modelYear
                         numberOfWheels:4
                            powerSource:powerSource
                              brandName:brandName
                              modelName:modelName]) {
        _numberOfDoors = numberOfDoors;
        _convertible = convertible;
        _hatchback = hatchback;
        _sunroof = sunroof;
        
        _randomNoise = @[@"BRRRMM", @"BRR BRR BRRR", @"PUM PUM"];
    }
    return self;
    
}


- (NSString *)goForward {
    return [NSString stringWithFormat:@"%@\n%@\n%@", [self start], [self changeGear:@"D"], @"Depress the gas pedal"];
}

- (NSString *)goBackward {
    return [NSString stringWithFormat:@"%@\n%@\n%@", [self start], [self changeGear:@"R"], @"Check your rear view mirror and depress the gas pedal"];
}

- (NSString *)stop {
    return [NSString stringWithFormat:@"%@\n%@", @"Depress break", [self changeGear:@"N"]];
}

- (NSString *)makeNoise{
    return [self generateRandomNoise];
}

#pragma mark - Private Methods

- (NSString *)generateRandomNoise {
    NSUInteger randomIndex = arc4random_uniform((u_int32_t)[self.randomNoise count]);
    
    return [self.randomNoise objectAtIndex:randomIndex];
}


#pragma mark - Override Methods
- (NSString *)vehicleDetailsString {
    NSString *superDetail = [super vehicleDetailsString];
    
    NSString *sunroofString = self.hasSunroof ? @"With Sunroof" : @"Without Sunroof";
    NSString *hatchbackString = self.hasHatchback ? @"With Hatchback" : @"Without Hatchback";
    NSString *convertibleString = self.isConvertible ? @"Convertible" : @"No Covertible";
    
    
    return [NSString stringWithFormat:@"%@\nNum. Doors: %ld\n%@\n%@\n%@", superDetail, self.numberOfDoors, sunroofString, hatchbackString, convertibleString];
}

@end
