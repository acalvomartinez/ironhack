//
//  EuroConverterViewController.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "EuroConverterViewController.h"

#import "EuroConverter.h"

@interface EuroConverterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation EuroConverterViewController

- (IBAction)pesetaToEuroButtonPressed:(id)sender {
    
    NSString *moneyString = self.textField.text;
    
    if ([moneyString intValue] != 0) {
        NSLog(@"Conversion: %u Ptas are %.2f €", [moneyString intValue], [EuroConverter convertFromPesetaToEuro:[moneyString intValue]]);
    } else {
        NSLog(@"Input error!");
    }
}

@end
