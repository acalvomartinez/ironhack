//
//  DetailViewController.m
//  GOTTableView
//
//  Created by Toni on 17/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "DetailViewController.h"
#import "Personaje.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptioTextView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Character";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.nameLabel.text = self.character.nombre;
    self.descriptioTextView.text = self.character.descripcion;
    UIImage *imageCharacter = [UIImage imageNamed:self.character.imagen];
    self.imageView.image = imageCharacter;
    self.imageView.clipsToBounds = YES;
    
    self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView.layer.borderWidth = 2.0;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.layer.masksToBounds = YES;

    self.backgroundImageView.image = imageCharacter;
    self.backgroundImageView.clipsToBounds = YES;
}

- (IBAction)deleteButtonPreseed:(id)sender {
    [self.delegate didPressedKillButton:self.character];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
