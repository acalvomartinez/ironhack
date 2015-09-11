//
//  ConverterViewController.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ConverterViewController.h"

#import "EuroConverter.h"

@interface ConverterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (weak, nonatomic) IBOutlet UIButton *ptaButton;
@property (weak, nonatomic) IBOutlet UIButton *euroButton;

@end

@implementation ConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInterface];
}

#pragma mark - Private Methods

- (void)initInterface {
    self.displayLabel.text = @"";
    self.ptaButton.enabled = NO;
    self.euroButton.enabled = YES;
}

- (IBAction)numberKeyButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    self.displayLabel.text = [self.displayLabel.text stringByAppendingString:button.titleLabel.text];
}

- (IBAction)ptaToEuroButtonPressed:(id)sender {
    self.euroButton.enabled = NO;
    self.ptaButton.enabled = YES;
    
    int ptas = [self.displayLabel.text intValue];
    
    float euros= [EuroConverter convertFromPesetaToEuro:ptas];
    self.displayLabel.text = [NSString stringWithFormat:@"%.2f",euros];
}

- (IBAction)euroToPtaButtonPressed:(id)sender {
    self.euroButton.enabled = YES;
    self.ptaButton.enabled = NO;
    
    float euros = [self.displayLabel.text floatValue];
    
    NSUInteger ptas = [EuroConverter convertFromEuroToPeseta:euros];
    self.displayLabel.text = @(ptas).stringValue;
}

- (IBAction)zeroButton:(id)sender {
    self.displayLabel.text = @"";
}

@end
