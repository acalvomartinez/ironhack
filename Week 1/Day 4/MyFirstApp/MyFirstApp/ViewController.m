//
//  ViewController.m
//  MyFirstApp
//
//  Created by Toni on 08/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak,nonatomic) UISegmentedControl *test;

@property (strong, nonatomic) NSArray *weekdays;

@property (strong, nonatomic) MyClass *shit1;
@property (strong, nonatomic) MyClass *shit2;

@end

@implementation ViewController

@synthesize myProtocolProperty;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"From Storyboard");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self doThings];
    
    self.weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thrusday", @"VIERNESS", @"SATURDAY", @"Sunday"];
    
    self.shit1 = [[MyClass alloc] init];
    self.shit2 = [[MyClass alloc] init];
    
    [self.shit1 addObserver:self.shit2 forKeyPath:@"name" options:kNilOptions context:nil];
    self.shit1.name = @"my name";
    
    [self.shit1 removeObserver:self.shit2 forKeyPath:@"name"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ALERT!!"
//                                                        message:@"Message"
//                                                       delegate:self
//                                              cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:@"OK", @"KD", nil];
//    
    //[alertView show];
}

- (void)doThings {
    self.doThingsExecuted = YES;
    NSLog(@"Done!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTap:(id)sender {
    NSLog(@"Done, Yo!");
}

- (void)myProtocolFirstMethod {
    
}

- (void)myProtocolSecondMethod {
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clicked: %ld %@", (long)buttonIndex, [alertView buttonTitleAtIndex:buttonIndex]);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"dismiss: %ld %@", (long)buttonIndex, [alertView buttonTitleAtIndex:buttonIndex]);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 7;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.weekdays objectAtIndex:row];
}

@end
