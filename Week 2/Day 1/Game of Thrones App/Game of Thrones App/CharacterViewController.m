//
//  CharacterViewController.m
//  Game of Thrones App
//
//  Created by Toni on 14/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "CharacterViewController.h"

@interface CharacterViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *okButton;

@end

@implementation CharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControllers];
}

#pragma mark - Setup Controllers

- (void)setupControllers {
    [self setupPickerView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupPickerView {
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    [self placeView:self.pickerView underView:self.imageView withHeightUnits:3];
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

@end
