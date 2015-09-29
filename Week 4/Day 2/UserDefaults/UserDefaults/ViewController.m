//
//  ViewController.m
//  UserDefaults
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUserDefault];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadUserDefault {
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    BOOL notifications = [[NSUserDefaults standardUserDefaults]  boolForKey:@"notifications"];
    
    self.usernameTextField.text = name;
    self.nicknameTextField.text = nickname;
    self.notificationsSwitch.on = notifications;
}

- (void)saveUserDefault {
    [[NSUserDefaults standardUserDefaults] setObject:self.usernameTextField.text forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.nicknameTextField.text forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setBool:self.notificationsSwitch.on forKey:@"notifications"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

- (IBAction)saveButtonPressed:(id)sender {
    [self saveUserDefault];
}

@end
