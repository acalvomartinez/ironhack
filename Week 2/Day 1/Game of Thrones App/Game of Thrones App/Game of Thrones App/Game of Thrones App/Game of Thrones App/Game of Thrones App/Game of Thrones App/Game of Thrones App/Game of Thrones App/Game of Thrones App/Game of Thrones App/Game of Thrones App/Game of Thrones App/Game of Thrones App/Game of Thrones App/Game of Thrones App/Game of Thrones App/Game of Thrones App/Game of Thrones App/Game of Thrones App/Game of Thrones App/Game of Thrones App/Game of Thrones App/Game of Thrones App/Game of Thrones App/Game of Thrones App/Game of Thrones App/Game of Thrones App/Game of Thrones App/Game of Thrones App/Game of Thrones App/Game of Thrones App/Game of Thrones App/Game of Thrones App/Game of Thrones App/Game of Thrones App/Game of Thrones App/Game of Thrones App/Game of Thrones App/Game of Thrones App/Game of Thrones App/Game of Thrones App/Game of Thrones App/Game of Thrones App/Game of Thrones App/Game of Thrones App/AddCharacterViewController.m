//
//  ViewController.m
//  Game of Thrones App
//
//  Created by Toni on 14/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AddCharacterViewController.h"
#import "PresentedViewController.h"

typedef NS_ENUM(NSUInteger, Evilness) {
    EvilnessGood,
    EvilnessBad,
    EvilnessVeryBad,
    EvilnessTrueEvil
};

@interface AddCharacterViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UITextView *bioTextView;
@property (nonatomic, strong) UISegmentedControl *houseSegmentedControl;
@property (nonatomic, strong) UIButton *addCharacterButton;
@property (nonatomic, strong) UISlider *evilnessSlider;
@property (nonatomic, strong) UISwitch *killSwitch;
@property (nonatomic, strong) UILabel *killLabel;

@end

@implementation AddCharacterViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawControls];
}

#pragma mark - Private Methods

- (void)drawControls {
    [self drawName];
    [self drawBiography];
    [self drawHouseSegmentedControl];
    [self drawEvil];
    [self drawKillSwitch];
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
    [self.houseSegmentedControl addTarget:self
                                   action:@selector(houseSelected:)
                         forControlEvents:UIControlEventValueChanged];
    [self placeView:self.houseSegmentedControl underView:self.bioTextView withHeightUnits:1];
}

- (void)drawEvil {
    UILabel *evilLabel = [UILabel new];
    evilLabel.text = @"Evil";
    [self placeView:evilLabel underView:self.houseSegmentedControl withHeightUnits:1];
    
    self.evilnessSlider = [UISlider new];
    self.evilnessSlider.minimumValue = 0;
    self.evilnessSlider.maximumValue = 100;
    self.evilnessSlider.minimumTrackTintColor = [UIColor redColor];
    self.evilnessSlider.maximumTrackTintColor = [UIColor greenColor];
    [self addEvilness:EvilnessGood toTextFieldLeftImage:self.nameTextField];
    [self.evilnessSlider addTarget:self action:@selector(evilnessChanged:) forControlEvents:UIControlEventValueChanged];
    [self placeView:self.evilnessSlider underView:evilLabel withHeightUnits:1];
}

- (void)drawKillSwitch {
    UIView *killView = [UIView new];
    [self placeView:killView underView:self.evilnessSlider withHeightUnits:1];
    
    self.killSwitch = [UISwitch new];
    [self.killSwitch addTarget:self action:@selector(killChanged:) forControlEvents:UIControlEventValueChanged];
    [killView addSubview:self.killSwitch];
    
    CGFloat labelX = self.killSwitch.frame.origin.x + self.killSwitch.frame.size.width + padding;
    CGFloat labelWidth = killView.frame.size.width - self.killSwitch.frame.size.width - padding;
    
    self.killLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, self.killSwitch.frame.origin.y, labelWidth, self.killSwitch.frame.size.height)];
    
    self.killLabel.text = @"Alive";
    
    [killView addSubview:self.killLabel];
}

- (void)drawAddCharacterButton {
    self.addCharacterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.addCharacterButton setTitle:@"Add Character" forState:UIControlStateNormal];
    [self placeView:self.addCharacterButton underView:self.killSwitch.superview withHeightUnits:1];
    [self.addCharacterButton addTarget:self
                                action:@selector(presentNextViewController)
                      forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBiographyPlaceholder {
    self.bioTextView.text = @"Biography here";
    self.bioTextView.textColor = [UIColor lightGrayColor];
    self.bioTextView.tag = 0;
}

#pragma mark - Target Actions

- (void)evilnessChanged:(UISlider *)evilnessSlider {
    Evilness evilness = (NSUInteger)evilnessSlider.value * (EvilnessTrueEvil / evilnessSlider.maximumValue) ;
    
    [self addEvilness:evilness toTextFieldLeftImage:self.nameTextField];
}

- (void)addEvilness:(Evilness)evilness toTextFieldLeftImage:(UITextField *)textField {
    UILabel *evilnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, heightUnit, heightUnit)];
    
    switch (evilness) {
        case EvilnessGood:
            evilnessLabel.text = @"😇";
            break;
        case EvilnessBad:
            evilnessLabel.text = @"😠";
            break;
        case EvilnessVeryBad:
            evilnessLabel.text = @"😡";
            break;
        case EvilnessTrueEvil:
            evilnessLabel.text = @"👿";
            break;
        default:
            break;
    }
    
    textField.rightView = evilnessLabel;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)houseSelected:(UISegmentedControl *)segmentedControl {
    NSString *imageName = [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex];
    
    [self addImageNamed:imageName toTextFieldLeftImage:self.nameTextField];
}


- (void)addImageNamed:(NSString *)imageName toTextFieldLeftImage:(UITextField *)textField {
    CGFloat height = textField.frame.size.height;
    
    UIImageView *houseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    houseImageView.image = [UIImage imageNamed:imageName];
    
    textField.leftView = houseImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)killChanged:(UISwitch *)killSwitch {
    [self killChangeTo:killSwitch.on];
}

- (void)killChangeTo:(BOOL)value {
    self.killLabel.text = value ? @"Dead" : @"Alive";
    self.killLabel.textColor = value ? [UIColor redColor] : [UIColor blackColor];
}

- (void)presentNextViewController {
    PresentedViewController *vc = [[PresentedViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
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
