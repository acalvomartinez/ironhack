//
//  ProfileViewController.h
//  MoviesModels
//
//  Created by Joan Romano on 9/29/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
