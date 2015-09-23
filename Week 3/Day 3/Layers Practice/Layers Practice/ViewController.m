//
//  ViewController.m
//  Layers Practice
//
//  Created by Toni on 23/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import "ScrollView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *purpleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *vader = [UIImage imageNamed:@"vader"];

    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(10, 50, 300, 200)
                                                         image:vader];
    
    [self.view addSubview:scrollView];
    
    /*
    UIVisualEffectView  *blurView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(10, 50, 300, 200)];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    blurView.effect = blurEffect;

    
    [self.view addSubview:blurView];
     */
}

- (void)layerImage {
    
    UIImage *vader = [UIImage imageNamed:@"vader"];
    
    self.purpleView.layer.contents = (id)[vader CGImage];
    self.purpleView.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.purpleView.layer.masksToBounds = YES;
    [self layerExercise];
}

- (void)layerExercise {
    CGRect bounds = CGRectMake(0, 0, 30, 30);
    
    CALayer *layer1 = [CALayer layer];
    layer1.bounds = bounds;
    layer1.backgroundColor = [[UIColor redColor] CGColor];
    CALayer *layer2 = [CALayer layer];
    layer2.bounds = bounds;
    layer2.backgroundColor = [[UIColor lightGrayColor] CGColor];
    CALayer *layer3 = [CALayer layer];
    layer3.bounds = bounds;
    layer3.backgroundColor = [[UIColor redColor] CGColor];
    
    [self.purpleView.layer addSublayer:layer1];
    [self.purpleView.layer addSublayer:layer2];
    [self.purpleView.layer addSublayer:layer3];
    
    layer1.position = CGPointMake(CGRectGetMidX(self.purpleView.bounds), CGRectGetMidY(self.purpleView.bounds));
    layer2.position = CGPointMake(CGRectGetMidX(self.purpleView.bounds) - 40, CGRectGetMidY(self.purpleView.bounds));
    layer3.position = CGPointMake(CGRectGetMidX(self.purpleView.bounds) + 40, CGRectGetMidY(self.purpleView.bounds));
}

- (void)vaderAvatar {
    CGFloat radius = self.purpleView.bounds.size.width / 2;
    
    self.purpleView.backgroundColor = [UIColor redColor];
    
    self.purpleView.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.purpleView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.purpleView.layer.borderWidth = 10;
    self.purpleView.layer.cornerRadius = radius;
    self.purpleView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.purpleView.layer.shadowRadius = 4;
    self.purpleView.layer.shadowOpacity = 0.5;
    self.purpleView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    
    
    UIImage *vader = [UIImage imageNamed:@"vader"];
    UIImageView *vaderImageView = [[UIImageView alloc]initWithImage:vader];
    vaderImageView.frame = self.purpleView.bounds;
    vaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    vaderImageView.layer.cornerRadius = radius;
    vaderImageView.layer.masksToBounds = YES;
    
    [self.purpleView addSubview:vaderImageView];
}
@end
