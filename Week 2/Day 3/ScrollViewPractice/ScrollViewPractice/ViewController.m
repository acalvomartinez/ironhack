//
//  MyScrollViewController.m
//  ScrollView
//
//  Created by Toni on 16/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *draggingButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deceleratingButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:NO];
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 200, 40)];
    self.label1.text = @"Hello";
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 900, 200, 40)];
    self.label2.text = @"World!";
    
    
    [self.scrollView addSubview:self.label1];
    [self.scrollView addSubview:self.label2];
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.label2.frame.origin.y + self.label2.frame.size.height + 100);
}


- (IBAction)label2ButtonPressed:(id)sender {
    [self.scrollView scrollRectToVisible:self.label2.frame animated:YES];
}

- (IBAction)label1ButtonPressed:(id)sender {
    [self.scrollView scrollRectToVisible:self.label1.frame animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.draggingButton.tintColor = [UIColor greenColor];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.draggingButton.tintColor = [UIColor redColor];
    self.deceleratingButton.tintColor = decelerate ? [UIColor greenColor] : [UIColor redColor];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.deceleratingButton.tintColor = [UIColor redColor];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    self.deceleratingButton.tintColor = [UIColor greenColor];
}


@end
