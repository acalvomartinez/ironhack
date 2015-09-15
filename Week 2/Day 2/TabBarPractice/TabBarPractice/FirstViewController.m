//
//  FirstViewController.m
//  TabBarPractice
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UIButton *addVCButton;
@property (nonatomic) NSUInteger vcIndex;

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    
    [self setupTextField];

    [self setupAddFirstViewControllerButton];
}


- (void)setupViewController {
    self.view.backgroundColor = [UIColor purpleColor];
    self.vcIndex = 0;
}

- (void)setupTextField {
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 200, 40)];
    self.titleTextField.borderStyle = UITextBorderStyleLine;
    self.titleTextField.backgroundColor = [UIColor whiteColor];
    self.titleTextField.delegate = self;
    [self.view addSubview:self.titleTextField];
}

- (void)setupAddFirstViewControllerButton {
    
    self.addVCButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    CGRect frame = CGRectMake(10 + self.titleTextField.frame.size.width + 10, 80, self.addVCButton.frame.size.width, self.addVCButton.frame.size.height);
    
    self.addVCButton.frame = frame;
    
    [self.view addSubview:self.addVCButton];
    
    [self.addVCButton addTarget:self action:@selector(addViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addViewController:(UIButton *)sender {
    NSString *title = self.titleTextField.text;
    
    if (title.length != 0) {
        NSMutableArray *viewControllers = [self.tabBarController.viewControllers mutableCopy];
        
        SecondViewController *vc = [SecondViewController new];
        vc.tabBarItem.title = self.titleTextField.text;
        vc.tabBarItem.image = [UIImage imageNamed:@"beer"];
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", (unsigned long)self.vcIndex];
        [viewControllers addObject:vc];
        
        [self.tabBarController setViewControllers:viewControllers animated:YES];
        
        self.vcIndex ++;
        
        [self.titleTextField resignFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}


@end
