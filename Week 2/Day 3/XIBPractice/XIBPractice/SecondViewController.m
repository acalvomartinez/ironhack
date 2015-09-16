//
//  SecondViewController.m
//  XIBPractice
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "SecondViewController.h"

#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second";
    
    UINib *viewNib = [UINib nibWithNibName:@"CustomView" bundle:[NSBundle mainBundle]];
    
    UIView *customView = [[viewNib instantiateWithOwner:self options:nil] lastObject];
    customView.frame = CGRectMake(0, 0, 259, 259);
    
    [self.view addSubview:customView];

}

- (IBAction)goToThirdButtonPressed:(id)sender {
    ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:thirdVC animated:YES];
}


@end
