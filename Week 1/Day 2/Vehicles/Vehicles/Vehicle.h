//
//  Vehicle.h
//  Vehicles
//
//  Created by Joan Romano on 9/7/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property (assign, nonatomic) int modelYear;
@property (assign, nonatomic) int numberOfWheels;
@property (strong, nonatomic) NSString *powerSource;
@property (strong, nonatomic) NSString *brandName;
@property (strong, nonatomic) NSString *modelName;

- (NSString *)goForward;
- (NSString *)goBackward;
- (NSString *)stop;
- (NSString *)makeNoise;
- (NSString *)changeGears:(NSString *)gears;
- (NSString *)turn:(int)degrees;

@end
