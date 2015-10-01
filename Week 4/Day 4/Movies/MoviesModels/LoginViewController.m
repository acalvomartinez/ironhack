//
//  LoginViewController.m
//  MoviesModels
//
//  Created by Joan Romano on 9/28/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "LoginViewController.h"
#import "UserEntity.h"
#import "UserEntity+CoreDataProperties.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *userNameTextField, *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)loginButtonAction:(id)sender {
    if (self.userNameTextField.text.length &&
        self.passwordTextField.text.length)
    {
        [self loginUserWithUsername:self.userNameTextField.text andPassword:self.passwordTextField.text];
    }
    else
    {
        NSLog(@"Invalid input");
    }
}

- (void)loginUserWithUsername:(NSString *)username andPassword:(NSString *)password{
    
    UserEntity *loggedUser = [self loggedUserWithUsername:username andPassword:password];
    if (!loggedUser)
    {
        loggedUser = [self addUserWithUsername:username andPassword:password];
    }
    
    if (loggedUser)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastLogin"];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogNotification object:loggedUser];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (UserEntity *)loggedUserWithUsername:(NSString *)username andPassword:(NSString *)password{
    UserEntity *loggedUser;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([UserEntity class])];
    request.predicate = [NSPredicate predicateWithFormat:@"userName=%@ AND userPassword=%@",username,password];
    NSArray *users = [self.managedObjectContext executeFetchRequest:request error:nil];
    if (users.count) {
        loggedUser = users.firstObject;
    }
    
    return loggedUser;
}

- (UserEntity *)addUserWithUsername:(NSString *)username andPassword:(NSString *)password{
    UserEntity *loggedUser=[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([UserEntity class]) inManagedObjectContext:self.managedObjectContext];
    loggedUser.userName = username;
    loggedUser.userPassword = password;
    [self.managedObjectContext save:nil];
    
    return loggedUser;
}

@end
