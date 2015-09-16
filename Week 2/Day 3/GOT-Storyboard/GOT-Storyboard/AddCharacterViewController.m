//
//  CharacterViewController.m
//  GOT-Storyboard
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AddCharacterViewController.h"

#import "SelectCharacterViewController.h"


typedef NS_ENUM(NSUInteger, Evilness) {
    EvilnessGood,
    EvilnessBad,
    EvilnessVeryBad,
    EvilnessTrueEvil
};

static CGFloat const heightUnit = 40;

@interface AddCharacterViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UITextView *biographyTextView;
@property (weak, nonatomic) IBOutlet UISlider *evilnessSlider;
@property (weak, nonatomic) IBOutlet UISwitch *aliveSwitch;
@property (weak, nonatomic) IBOutlet UILabel *aliveLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSString *imageName;

@end

@implementation AddCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNameTextField];
    [self setupBiography];
    [self setupEvilness];
    [self setupAliveLabel];
    [self setupScrollView];
}

- (void)setupNameTextField {
    self.nameTextField.delegate = self;
}

- (void)setupBiography {
    [self addBiographyPlaceholder];
    self.biographyTextView.delegate = self;
    
}

- (void)addBiographyPlaceholder {
    self.biographyTextView.text = @"Biography here";
    self.biographyTextView.textColor = [UIColor lightGrayColor];
    self.biographyTextView.tag = 0;
}

- (void)setupEvilness {
    self.evilnessSlider.minimumValue = 0;
    self.evilnessSlider.maximumValue = 100;
    self.evilnessSlider.minimumTrackTintColor = [UIColor redColor];
    self.evilnessSlider.maximumTrackTintColor = [UIColor greenColor];
    [self addEvilness:EvilnessGood toTextFieldLeftImage:self.nameTextField];
}

- (void)setupAliveLabel {
    self.aliveLabel.textColor = [UIColor greenColor];
}

- (void)setupScrollView {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height+ 100);
    self.scrollView.delegate = self;
}

- (IBAction)houseChanged:(UISegmentedControl *)segmentedControl {
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


- (IBAction)aliveSwitchChanged:(UISwitch *)sender {
    [self aliveChangeTo:sender.on];
}

- (void)aliveChangeTo:(BOOL)value {
    self.aliveLabel.text = value ? @"Alive" : @"Dead" ;
    self.aliveLabel.textColor = value ?  [UIColor greenColor] : [UIColor redColor];
}

- (IBAction)evilnessSliderChanged:(UISlider *)evilnessSlider {
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

- (IBAction)done:(UIStoryboardSegue *)segue {
    SelectCharacterViewController *selectViewController = (SelectCharacterViewController *)segue.sourceViewController;
    self.imageName = selectViewController.imageNameSelected;
    [self loadImageNamed:self.imageName];
}

- (void)loadImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.scrollView endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {
    if ([segue.destinationViewController isKindOfClass:[SelectCharacterViewController class]] && self.imageName) {
        SelectCharacterViewController *selectViewController = (SelectCharacterViewController *)segue.destinationViewController;
        selectViewController.imageNameSelected = self.imageName;
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == self.biographyTextView && textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.biographyTextView && textView.text.length == 0) {
        [self addBiographyPlaceholder];
    }
    
    [textView resignFirstResponder];
}

@end
