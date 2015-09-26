//
//  ImagePreviewViewController.m
//  GestureRecognizers
//
//  Created by Gorka Magaña on 25/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "ImagePreviewViewController.h"

@interface ImagePreviewViewController ()
@property (nonatomic, weak, readwrite) IBOutlet UIImageView *imageView;
@end

@implementation ImagePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.fullSizedImage;
    
}

- (void)setFullSizedImage:(UIImage *)fullSizedImage {
    _fullSizedImage = fullSizedImage;
    _imageView.image = fullSizedImage;
}

- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
