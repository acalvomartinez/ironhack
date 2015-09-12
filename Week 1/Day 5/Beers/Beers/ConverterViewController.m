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

@property (nonatomic) BOOL mustResetDisplay;
@property (nonatomic, strong) NSString *currency;

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
    self.mustResetDisplay = NO;
    self.currency = self.ptaButton.titleLabel.text;
}

- (IBAction)numberKeyButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (self.mustResetDisplay) {
        [self resetDisplay];
    }
    
    NSString *amount = @"";
    if (![self.displayLabel.text isEqualToString:@""]) {
        amount = [self.displayLabel.text substringToIndex:self.displayLabel.text.length - (self.currency.length + 1)];
    }
    
    self.displayLabel.text = [NSString stringWithFormat:@"%@%@ %@", amount, button.titleLabel.text, self.currency];
    
    self.mustResetDisplay = NO;
}

- (IBAction)ptaToEuroButtonPressed:(id)sender {
    self.euroButton.enabled = NO;
    self.ptaButton.enabled = YES;
    
    self.currency = self.euroButton.titleLabel.text;
    
    int ptas = [self.displayLabel.text intValue];
    
    float euros= [EuroConverter convertFromPesetaToEuro:ptas];
    self.displayLabel.text = [NSString stringWithFormat:@"%.2f %@", euros, self.currency];

    
    self.mustResetDisplay = YES;
}

- (IBAction)euroToPtaButtonPressed:(id)sender {
    self.euroButton.enabled = YES;
    self.ptaButton.enabled = NO;
    
    self.currency = self.ptaButton.titleLabel.text;
    
    float euros = [self.displayLabel.text floatValue];
    
    NSUInteger ptas = [EuroConverter convertFromEuroToPeseta:euros];
    self.displayLabel.text = [NSString stringWithFormat:@"%d %@", ptas, self.currency];
    
    self.mustResetDisplay = YES;
}

- (IBAction)zeroButton:(id)sender {
    [self resetDisplay];
}

- (void)resetDisplay {
    self.displayLabel.text = @"";
}

@end
