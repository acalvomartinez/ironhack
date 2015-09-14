//
//  ViewController.m
//  Game of Thrones App
//
//  Created by Toni on 14/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AddCharacterViewController.h"

static CGFloat const padding = 8;
static CGFloat const margin = 10;
static CGFloat const heightUnit = 40;
static CGFloat const initialUpperMargin = 40;

@interface AddCharacterViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, assign) CGSize screenSize;
@property (nonatomic, strong) UITextView *bioTextView;
@property (nonatomic, strong) UISegmentedControl *houseSegmentedControl;
@property (nonatomic, strong) UIButton *addCharacterButton;

@end

@implementation AddCharacterViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenSize = self.view.frame.size;
    
    [self drawControls];
}

#pragma mark - Private Methods

- (void)drawControls {
    [self drawName];
    [self drawBiography];
    [self drawHouseSegmentedControl];
    [self drawAddCharacterButton];
}

- (void)drawName {
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"Name";
    [self placeView:nameLabel underView:nil withHeightUnits:1];
    
    self.nameTextField = [UITextField new];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.delegate = self;
    [self placeView:self.nameTextField underView:nameLabel withHeightUnits:1];
}

- (void)drawBiography {
    UILabel *bioLabel = [UILabel new];
    bioLabel.text = @"Biography";
    [self placeView:bioLabel underView:self.nameTextField withHeightUnits:1];
    
    self.bioTextView = [UITextView new];
    [self addBiographyPlaceholder];
    self.bioTextView.delegate = self;
    [self placeView:self.bioTextView underView:bioLabel withHeightUnits:3];
}

- (void)drawHouseSegmentedControl {
    self.houseSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Stark",
                                                                             @"Lannister",
                                                                             @"Targaryen",
                                                                             @"Baratheon",
                                                                             @"Tully"]];
    [self placeView:self.houseSegmentedControl underView:self.bioTextView withHeightUnits:1];
}

- (void)drawAddCharacterButton {
    self.addCharacterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.addCharacterButton setTitle:@"Add Character" forState:UIControlStateNormal];
    [self placeView:self.addCharacterButton underView:self.houseSegmentedControl withHeightUnits:1];
}

- (void)addBiographyPlaceholder {
    self.bioTextView.text = @"Biography here";
    self.bioTextView.textColor = [UIColor lightGrayColor];
    self.bioTextView.tag = 0;
}

#pragma mark - Control Positioning

- (void)placeView:(UIView *)bottomView underView:(UIView *)upperWiew withHeightUnits:(CGFloat)heightUnits {
    if (!upperWiew) {
        bottomView.frame = CGRectMake(padding, initialUpperMargin, self.screenSize.width - (padding*2), heightUnits * heightUnit);
    } else {
        bottomView.frame = [self frameUnderFrame:upperWiew.frame withHeightUnits:heightUnits];
    }
    
    [self.view addSubview:bottomView];
}

- (CGRect)frameUnderFrame:(CGRect)sourceFrame withHeightUnits:(CGFloat)heightUnits {
    CGFloat y = sourceFrame.origin.y + sourceFrame.size.height + margin;
    return CGRectMake(padding, y, self.screenSize.width - (padding*2), heightUnit * heightUnits);
}


#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nameTextField) {
        NSString *name = textField.text;
        
        [self.addCharacterButton setTitle:[NSString stringWithFormat:@"Add %@", name]
                                 forState:UIControlStateNormal];
    }
    
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == self.bioTextView && textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.bioTextView && textView.text.length == 0) {
        [self addBiographyPlaceholder];
    }
    
    [textView resignFirstResponder];
}

@end
