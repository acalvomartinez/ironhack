//
//  UserLoginViewController.m
//  MoviesModels
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Ironhack. All rights reserved.
//

#import "UserLoginViewController.h"

#import "UserEntity+CoreDataProperties.h"

@interface UserLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    if (self.usernameTextField.text.length == 0 && self.passwordTextField.text == 0) {
        self.usernameTextField.backgroundColor = [UIColor redColor];
        self.passwordTextField.backgroundColor = [UIColor redColor];
        return;
    }
    
    [self loginUserWithName:self.usernameTextField.text password:self.passwordTextField.text];
    
}

- (void)loginUserWithName:(NSString *)name password:(NSString *)password {
    
    UserEntity *loggedUser = [self loggedUserWithName:name password:password];
    
    if (!loggedUser) {
        loggedUser = [self addUserWithName:name password:password];
    }
    
    if (loggedUser) {
        
        [self saveLastLoginDate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedNotification" object:self userInfo:@{@"userLogged":loggedUser}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (UserEntity *)loggedUserWithName:(NSString *)name password:(NSString *)password {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@ && password = %@", name, password];
    
    NSError *error;
    NSArray *fetchResult = [self.managedContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchResult.count?[fetchResult firstObject]:nil;
}

- (void)saveLastLoginDate {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastLoginDate"];
}

- (UserEntity *)addUserWithName:(NSString *)name password:(NSString *)password {
    
    UserEntity *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([UserEntity class]) inManagedObjectContext:self.managedContext];
    
    user.name = name;
    user.password = password;
    
    NSError *error;
    [self.managedContext save:&error];
    
    return user;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
