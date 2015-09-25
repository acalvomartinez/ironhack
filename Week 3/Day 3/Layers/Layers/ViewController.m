//
//  ViewController.m
//  Layers
//
//  Created by Toni on 23/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

/*
 1. Add the works and Best-script images located in the repo.
 2. Create and add a CAScrollLayer, setting its height to the same as the view's layer and its width 2 times the width of the
 view's layer. Note that this layer's width and height is also the total content size of the scrollable area. So, in this
 exercise, we want to have an image in the first half of the scrollable area and a second image in the second half.
 3. Set the background color of the CAScrollLayer to a pale purple.
 4. Use the position property of the layer to properly set the layer's position.
 5. Add a button to the view to allow the user to scroll from one position to another. Name it scroll .
 6. Now, add two sublayers to the CAScrollLayer that will hold an image each one (hints: remember to use the contents
 property). Set each layer's position to be centered vertically and horizontally (recall that the images have to be center
 horizontally in their respective half of the scrollable area).
 7. Finally, using target-action, implement a method that will switch the scroll position to show the first or second image,
 whatever it corresponds.
 8. Run the app to check the scroll layer scrolls properly each time you press the button.
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self otherSpecialLayersExercise];
}


- (void)basicLayersExercise {
    CALayer *layer1 = [CALayer layer];
    layer1.bounds = CGRectMake(0, 0, 100, 200);
    layer1.position = CGPointMake(150, 150);
    layer1.backgroundColor = [[UIColor purpleColor] CGColor];
    
    CALayer *layer2 = [CALayer layer];
    layer2.bounds = CGRectMake(0,0, 100, 200);
    layer2.position = CGPointMake(100, 170);
    layer2.backgroundColor = [[UIColor greenColor] CGColor];
    
    CALayer *layer3 = [CALayer layer];
    layer3.bounds = CGRectMake(0, 0, 100, 200);
    layer3.position = CGPointMake(75, 200);
    layer3.backgroundColor = [[UIColor redColor] CGColor];
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    
    
    UIImage *iconImage = [UIImage imageNamed:@"icon"];
    
    CALayer *iconLayer = [CALayer layer];
    iconLayer.bounds = CGRectMake(0, 0, 60, 60);
    iconLayer.position = CGPointMake(150, 250);
    iconLayer.contents = (id)iconImage.CGImage;
    iconLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:iconLayer];
    
}

- (void)scrollLayerExercise {
    CAScrollLayer *layer = [CAScrollLayer layer];
    layer.bounds = CGRectMake(0,0,self.view.frame.size.width*2,self.view.frame.size.height);
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    layer.anchorPoint = CGPointMake(0,0);
    layer.position = CGPointMake(0,0);
    [self.view.layer addSublayer:layer];
    
    NSLog(@"%@", NSStringFromCGRect(layer.bounds));
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100, CGRectGetMaxY(self.view.bounds) - 80, 200, 40);
    [button setTintColor:[UIColor whiteColor]];
    [button setTitle:@"Scroll" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(scrollButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *image1 = [UIImage imageNamed:@"image1"];
    CALayer *layer1 = [self createLayerWithBounds:CGRectMake(0, 0, 300, 400) image:image1];
    layer1.position = CGPointMake(layer.bounds.size.width/4, layer.bounds.size.height/2);
    [layer addSublayer:layer1];

    
    UIImage *image2 = [UIImage imageNamed:@"image2"];
    CALayer *layer2 = [self createLayerWithBounds:CGRectMake(0, 0, 300, 400) image:image2];
    layer2.position = CGPointMake(layer.bounds.size.width * 3 / 4, layer.bounds.size.height/2);
    [layer addSublayer:layer2];
}

- (CALayer*)createLayerWithBounds:(CGRect)bounds image:(UIImage *)image {
    CALayer *layer = [CALayer layer];
    layer.bounds = bounds;
    layer.contents = (id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspectFill;
    layer.masksToBounds = YES;
    return layer;
}

- (void)scrollButtonPressed:(UIButton *)button {
    static BOOL isOnRight;
    
    CAScrollLayer *layer = (CAScrollLayer *)[[self.view.layer sublayers] objectAtIndex:0];
    CGPoint destination;
    if (!isOnRight) {
        destination.x = layer.frame.size.width/2;
    } else {
        destination.x = 0;
    }
    
    [UIView animateWithDuration:2 animations:^{
        [layer scrollToPoint:destination];
    } completion:^(BOOL finished) {
        isOnRight = !isOnRight;
    }];
}


- (void)otherSpecialLayersExercise {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[UIColor yellowColor].CGColor,
                             (id)[UIColor orangeColor].CGColor];
    gradientLayer.locations = @[@0.0,@0.5];
    gradientLayer.bounds = self.view.bounds;
    gradientLayer.anchorPoint = CGPointMake(0,0);
    gradientLayer.position = CGPointMake(0,0);
    [self.view.layer addSublayer:gradientLayer];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"I'm a CATextLayer";
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.backgroundColor = [UIColor whiteColor].CGColor;
    textLayer.bounds = CGRectMake(0,0,300,50);
    textLayer.anchorPoint = CGPointMake(0,0);
    textLayer.position = CGPointMake(10,50);
    [self.view.layer addSublayer:textLayer];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shapeLayer.bounds = CGRectMake(0,0,200,200);
    shapeLayer.anchorPoint = CGPointMake(0.5,0.5);
    shapeLayer.position = CGPointMake(160,160);
    
    CGPathRef *path;
    
    [self.view.layer addSublayer:textLayer];
}

@end
