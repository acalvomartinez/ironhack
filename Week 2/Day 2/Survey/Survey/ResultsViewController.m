//
//  ResultsViewController.m
//  Survey
//
//  Created by Toni on 15/09/15.
//  Copyright (c) 2015 Toni. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

@property (nonatomic, strong) UILabel *option1Label;
@property (nonatomic, strong) UILabel *option2Label;
@property (nonatomic, strong) UILabel *option3Label;

@property (nonatomic) NSUInteger option1Result;
@property (nonatomic) NSUInteger option2Result;
@property (nonatomic) NSUInteger option3Result;

@end

@implementation ResultsViewController

- (instancetype)init {
    if (self = [super init]) {
         [self observeNotifications];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildOptionLabels];
   
}

- (void)buildOptionLabels {
    [self buildOptionLabel1];
    [self buildOptionLabel2];
    [self buildOptionLabel3];
    
    [self refreshResults];
}

- (void)observeNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:@"didAnswer"
                                               object:nil];
}

- (void)buildOptionLabel1 {
    self.option1Label.frame = CGRectMake(100, 100, 300, 40);
    [self.view addSubview:self.option1Label];
}

- (void)buildOptionLabel2 {
    self.option2Label.frame = CGRectMake(100, 145, 300, 40);
    [self.view addSubview:self.option2Label];
}

- (void)buildOptionLabel3 {
    self.option3Label.frame = CGRectMake(100, 190, 300, 40);
    [self.view addSubview:self.option3Label];
}

- (void)refreshResults {
    self.option1Label.text = [NSString stringWithFormat:@"Total answers: %lu", self.option1Result];
    self.option2Label.text = [NSString stringWithFormat:@"Total answers: %lu", self.option2Result];
    self.option3Label.text = [NSString stringWithFormat:@"Total answers: %lu", self.option3Result];
}

- (void)didReceiveNotification:(NSNotification *)notification {
    NSLog(@"Notification recived");
    
    NSUInteger questionNumber = [notification.userInfo[@"question"] integerValue];
    
    switch (questionNumber) {
        case 0:
            self.option1Result++;
            break;
        case 1:
            self.option2Result++;
            break;
        case 2:
            self.option3Result++;
            break;

        default:
            break;
    }
    
    
    
    [self refreshResults];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UILabel *)option1Label {
    if (!_option1Label) {
        _option1Label = [UILabel new];
    }
    return _option1Label;
}


- (UILabel *)option2Label {
    if (!_option2Label) {
        _option2Label = [UILabel new];
    }
    return _option2Label;
}

- (UILabel *)option3Label {
    if (!_option3Label) {
        _option3Label = [UILabel new];
    }
    return _option3Label;
}

@end
