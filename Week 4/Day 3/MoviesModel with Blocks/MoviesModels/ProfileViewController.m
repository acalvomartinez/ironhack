//
//  ProfileViewController.m
//  MoviesModels
//
//  Created by Joan Romano on 9/29/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "ProfileViewController.h"

#import "UserEntity.h"
#import "UserEntity+CoreDataProperties.h"
#import "LoginViewController.h"

@interface ProfileViewController ()

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

@end

@implementation ProfileViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin:) name:UserDidLogNotification object:nil];
        self.title = @"Profile";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateUserInfoWithUser:[self loggedUser]];
}

- (void)userDidLogin:(NSNotification *)notification
{
    [self updateUserInfoWithUser:[self loggedUser]];
}

- (void)updateUserInfoWithUser:(UserEntity *)user
{
    self.userNameLabel.text = user.userName;
}

- (IBAction)logoutButtonAction:(id)sender
{
    [self logoutUser];
}

- (UserEntity *)loggedUser
{
    UserEntity *loggedUser;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([UserEntity class])];
    request.predicate = [NSPredicate predicateWithFormat:@"1=1"];
    NSArray *users = [self.managedObjectContext executeFetchRequest:request error:nil];
    if (users.count) {
        loggedUser = users.firstObject;
    }
    
    return loggedUser;
}

- (void)logoutUser
{
    [self deleteUsersCache];
    [self deleteLoggedUser];
    
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.managedObjectContext = self.managedObjectContext;
    [self.tabBarController presentViewController:loginViewController animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:self];
        [self.tabBarController setSelectedIndex:0];
    }];
}

- (NSString *)savesFilePath
{
    UserEntity *loggedUser = [self loggedUser];
    NSString *savesFilePath;
    if (loggedUser) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        savesFilePath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_saves.plist",loggedUser.userName]];
    }
    return savesFilePath;
}

- (void)deleteUsersCache
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *savesFilePath = [self savesFilePath];
    if ([fileManger fileExistsAtPath:savesFilePath]) {
        [self logSavesFileAttribuesAtPath:savesFilePath];
        NSError *error;
        [fileManger removeItemAtPath:savesFilePath error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
    }
}

- (void)logSavesFileAttribuesAtPath:(NSString *)savesFilePath
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error;
    NSDictionary *attributes = [fileManger attributesOfItemAtPath:savesFilePath error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    } else {
        NSLog(@"%@",attributes);   
    }
}

- (void)deleteLoggedUser
{
    [self.managedObjectContext deleteObject:[self loggedUser]];
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
}

@end
