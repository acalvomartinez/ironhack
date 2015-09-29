//
//  UserProfileViewController.m
//  MoviesModels
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserEntity.h"
#import "UserLoginViewController.h"

@interface UserProfileViewController ()

@property (strong, nonatomic) UserEntity *user;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (nonatomic, strong) NSString *defaultPath;
@property (nonatomic, strong) NSString *plistFilePath;

@end

@implementation UserProfileViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoggedNotification:) name:@"userLoggedNotification" object:nil];
        
        _user = [self loggedUser];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.usernameLabel.text = self.user.name;
}

- (UserEntity *)loggedUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest  fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    
    NSError *error;
    NSArray *fetchResult = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchResult count] == 0)
    {
        return nil;
    }
    
    return [fetchResult firstObject];
}


- (void)handleUserLoggedNotification:(NSNotification *)notification {
    self.user = [notification.userInfo objectForKey:@"userLogged"];
    self.navigationItem.title = self.user.name;
    
}
- (IBAction)LogoutButtonPressed:(id)sender {
    [self setupPlistPath];
    [self resetCacheData];
    [self removeLoggedUser];
    
    [self performSegueWithIdentifier:@"userLogin" sender:self];
}

- (void)setupPlistPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    self.defaultPath = [paths firstObject];
    
    self.plistFilePath = [self.defaultPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_saves.plist", self.user.name]];
}

- (void)removeLoggedUser {
    [self.managedContext deleteObject:self.user];
    self.user = nil;
    NSError *error;
    [self.managedContext save:&error];
}

- (void)resetCacheData{
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    if (![fileManager removeItemAtPath:self.plistFilePath error:&error]){
        NSLog(@"[Error] %@ (%@)",error, self.plistFilePath);
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserLoginViewController *viewController = segue.destinationViewController;
    viewController.managedContext = self.managedContext;
    
    self.tabBarController.selectedIndex = 0;
}



@end
