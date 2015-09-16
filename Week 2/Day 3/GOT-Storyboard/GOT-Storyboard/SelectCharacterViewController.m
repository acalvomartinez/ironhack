//
//  SelectCharacterViewController.m
//  GOT-Storyboard
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "SelectCharacterViewController.h"

#import "CharactersNameDataSource.h"

@interface SelectCharacterViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) CharactersNameDataSource *datasource;

@end

@implementation SelectCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickerView];
    [self setupImageView];
}

- (void)setupPickerView {
    
    self.datasource = [[CharactersNameDataSource alloc] init];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    if (self.imageNameSelected) {
        NSUInteger selectedIndex = [self.datasource.names indexOfObject:self.imageNameSelected];
        
        [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
    }
    
    
}

- (void)setupImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
    
    if (self.imageNameSelected) {
        [self presentImage:self.imageNameSelected];
    } else {
        [self presentImage:[self.datasource.names objectAtIndex:0]];
    }
}


- (void)presentImage:(NSString *)imageNamed {
    self.imageView.image = [UIImage imageNamed:imageNamed];
    self.imageNameSelected = imageNamed;
}



#pragma mark - PickerVide Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.datasource.names objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self presentImage:[self.datasource.names objectAtIndex:row]];
}

#pragma mark - PickerView Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.datasource.names count];
}

@end
