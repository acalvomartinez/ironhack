//
//  UserLoginViewController.h
//  MoviesModels
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSManagedObjectContext;

@interface UserLoginViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedContext;

@end
