//
//  ViewController.m
//  ScrollViewZoomPractice
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
}

- (IBAction)sliderChagend:(UISlider *)slider {
    self.scrollView.zoomScale = slider.value;
    self.imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   return self.imageView;
}

@end
