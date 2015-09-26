//
//  ViewController.m
//  Shapes
//
//  Created by Gorka Magaña on 23/09/15.
//  Copyright © 2015 Gorka Magaña. All rights reserved.
//

#import "ViewController.h"
#import "DeformableView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DeformableView *doformableView;
@property (nonatomic) CGFloat touchBeganX;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint locationInView = [touch locationInView:self.view];
    self.touchBeganX = locationInView.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGFloat xMovement = [touch locationInView:self.view].x - self.touchBeganX;
    
    self.doformableView.xDisplacement = xMovement;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.doformableView setXDisplacement:0 animated:YES];
}

@end
