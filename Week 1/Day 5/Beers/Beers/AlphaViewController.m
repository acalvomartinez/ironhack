//
//  AlphaViewController.m
//  Beers
//
//  Created by Toni on 11/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "AlphaViewController.h"

@interface AlphaViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL isFirstImage;

@end

@implementation AlphaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFirstImage = YES;
}

- (IBAction)sliderMoved:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    self.imageView.alpha = slider.value;
}

- (IBAction)buttonPressed:(id)sender {
    UIImage *image;
    if (self.isFirstImage) {
        image = [UIImage imageNamed:@"image-2.png"];
    } else {
        image = [UIImage imageNamed:@"image-1.jpg"];
    }
    
    self.imageView.image = image;
    
    self.isFirstImage = !self.isFirstImage;
}

- (IBAction)downloadButtonPressed:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://diyfather.com/wp-content/uploads/darth-vader-cat1.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.imageView.image = image;
}


@end
