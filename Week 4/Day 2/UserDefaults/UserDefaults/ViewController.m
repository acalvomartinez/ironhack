//
//  ViewController.m
//  UserDefaults
//
//  Created by Toni on 29/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

static BOOL const kUseDefaults = NO;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;

@property (nonatomic, strong) NSString *plistFilePath;
@property (nonatomic, strong) NSString *defautlPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (kUseDefaults) {
        [self loadUserDefault];
    } else {
        [self setupPlistPath];
        [self loadDefaultsFromPlist];
    }
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
}

- (void)loadDefaultsFromPlist {
    NSArray *defaults = [NSArray arrayWithContentsOfFile:self.plistFilePath];
    
    self.usernameTextField.text = defaults[0];
    self.nicknameTextField.text = defaults[1];
    self.notificationsSwitch.on = [defaults[2] boolValue];
    
}

- (void)setupPlistPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    //self.plistFilePath = [path stringByAppendingString:@"usersdefault.plist"];
    self.defautlPath = [path stringByAppendingPathComponent:@"Preferences"];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.defautlPath]){
        [fileManager createDirectoryAtPath:self.defautlPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    self.plistFilePath = [self.defautlPath stringByAppendingPathComponent:@"userDefault.plist"];
    
    
    
}

- (void)saveDefaulsToPlist {
    NSString *name = self.usernameTextField.text;
    NSString *nickname = self.nicknameTextField.text;
    NSNumber *notifications = [NSNumber numberWithBool:self.notificationsSwitch.on];
    
    NSArray *defaults = @[name, nickname, notifications];
    
    [defaults writeToFile:self.plistFilePath atomically:YES];
    
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if (kUseDefaults) {
        [self saveUserDefault];
    } else {
        [self saveDefaulsToPlist];
    }
}

- (IBAction)resetButtonPressed:(id)sender {
    self.usernameTextField.text = @"";
    self.nicknameTextField.text = @"";
    self.notificationsSwitch.on = NO;
    
    [self resetDirectory];
    
}

- (void)resetDirectory{

    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    if (![fileManager removeItemAtPath:self.defautlPath error:&error]){
        NSLog(@"[Error] %@ (%@)",error, self.defautlPath);
    }
}
- (IBAction)logButtonPressed:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:self.defautlPath error:&error];
    NSLog(@"%@", contents);
}
@end
