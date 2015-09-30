//
//  LoginViewController.h
//  MoviesModels
//
//  Created by Joan Romano on 9/28/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const UserDidLogNotification = @"UserDidLogNotification";

@interface LoginViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
