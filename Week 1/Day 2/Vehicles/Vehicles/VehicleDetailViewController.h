//
//  VehicleDetailViewController.h
//  Vehicles
//
//  Created by Joan Romano on 9/7/15.
//  Copyright (c) 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

//Forward declaration of a class to be imported in the .m file
@class Vehicle;

@interface VehicleDetailViewController : UIViewController

@property (strong, nonatomic) Vehicle *detailVehicle;

@end
