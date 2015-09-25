//
//  ViewController.m
//  Animations Practice
//
//  Created by Toni on 24/09/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *ballView;
@property (weak, nonatomic) IBOutlet UIImageView *dancerView;
@property (nonatomic, strong) UIView *motionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    self.motionView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.motionView];
;
    self.ballView.backgroundColor = [UIColor redColor];
    
}

- (void)layerBasicAnimation {
    CABasicAnimation *cornerRadiusAnimation = [self createCornerRadiusAnimationWithToValue:40];
    CABasicAnimation *opacityAnimation = [self createOpacityAnimationWithToValue:0.5];

    NSArray *animations = @[cornerRadiusAnimation];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 3.0;
    groupAnimation.delegate = self;
    groupAnimation.animations = animations;
    
    [self.motionView.layer addAnimation:cornerRadiusAnimation forKey:@"groupAnimation"];
    //self.motionView.layer.cornerRadius = 40;
    
}

- (CABasicAnimation *)createCornerRadiusAnimationWithToValue:(CGFloat)value {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(value);
    basicAnimation.beginTime = 1.0;
    basicAnimation.duration = 1.0;
    basicAnimation.delegate = self;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:.37 :.47 :.95 :.48];
    
    basicAnimation.timingFunction = timingFunction;
    
    return basicAnimation;
}

- (CABasicAnimation *)createOpacityAnimationWithToValue:(CGFloat)value {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.toValue = @(value);
    basicAnimation.duration = 1.0;
    basicAnimation.delegate = self;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:.37 :.47 :.95 :.48];
    
    basicAnimation.timingFunction = timingFunction;
    
    return basicAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@ ended!", anim);
}

- (void)keyFrameAnimationTest {
    [UIView animateKeyframesWithDuration:10.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            CGPoint center = CGPointMake(50, 50);
            self.motionView.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2 relativeDuration:1.0 animations:^{
            CGPoint center = CGPointMake(60, 60);

            self.motionView.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:4 relativeDuration:1.0 animations:^{
            CGPoint center = CGPointMake(700, 50);
            self.motionView.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:6 relativeDuration:1.0 animations:^{
            CGPoint center = CGPointMake(150, 150);

            self.motionView.center = center;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:8 relativeDuration:1.0 animations:^{
            CGPoint center = CGPointMake(530, 250);

            self.motionView.center = center;
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"%@",self.motionView);
    }];
}

- (void)springAnimationTest {
    [self.dancerView startAnimating];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        CGPoint center = CGPointMake(self.dancerView.center.x, self.dancerView.center.y-50);
        self.dancerView.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.3 options:0 animations:^{
            CGPoint center = CGPointMake(self.dancerView.center.x, self.dancerView.center.y+50);
            self.dancerView.center = center;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)setupDancerGuy {
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:16];
    
    for (NSUInteger i=1; i <= 16; i++) {
        NSString *name = [NSString stringWithFormat:@"win_%lu",(unsigned long)i];
        [images addObject:[UIImage imageNamed:name]];
    }
    self.dancerView.contentMode = UIViewContentModeCenter;
    self.dancerView.animationImages = [images copy];
    self.dancerView.animationDuration = 0.5;
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    
//    sender.enabled = NO;
//    
//    [self.dancerView startAnimating];
//    
//    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
//        self.ballView.backgroundColor = [UIColor yellowColor];
//        self.ballView.bounds = [self multiplyFrame:self.ballView.bounds by:2];
//        self.ballView.transform = CGAffineTransformRotate(self.ballView.transform,M_PI);
//    } completion:^(BOOL finished) {
//        self.ballView.backgroundColor = [UIColor redColor];
//        self.ballView.bounds = [self multiplyFrame:self.ballView.bounds by:0.5];
//        
//        [self.dancerView stopAnimating];
//        sender.enabled = YES;
//    }];
    
    [self layerBasicAnimation];
}

- (CGRect)multiplyFrame:(CGRect)frame by:(CGFloat)amount {
    return CGRectMake(frame.origin.x * amount, frame.origin.y * amount, frame.size.width * amount, frame.size.height *amount);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
