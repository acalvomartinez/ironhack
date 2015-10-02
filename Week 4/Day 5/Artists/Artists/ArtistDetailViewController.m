//
//  ArtistDetailViewController.m
//  Artists
//
//  Created by Toni on 02/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ArtistDetailViewController.h"

#import "Artist.h"

@interface ArtistDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stageLabel;

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDetail];
}


- (void)setupDetail {
    self.descriptionTextView.textColor = [UIColor whiteColor];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.stageLabel.textColor = [UIColor whiteColor];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.nameLabel.text = self.artist.name;
    self.stageLabel.text = self.artist.stage;
    self.descriptionTextView.text = self.artist.longDescription;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.artist.imageURL]];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
